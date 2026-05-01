<?php

namespace app\admin\controller\miniapp;

use app\common\controller\Backend;
use think\Db;

/**
 * 小程序用户设置
 *
 * @icon fa fa-mobile
 */
class UserSetting extends Backend
{
    protected $model = null;
    protected $searchFields = 'id,tel,username,nickname,invite_code';
    protected $noNeedRight = ['selectpage'];
    const FINANCE_TYPE_ADMIN_RECHARGE = 8;
    const PAY_CONFIG_DEFAULT_TYPE = 'USDT-TRC20';

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\MiniappUser;
        $this->assignconfig('statusList', $this->model->getStatusList());
    }

    public function index()
    {
        $this->request->filter(['strip_tags', 'trim']);
        if ($this->request->isAjax()) {
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }

            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $query = $this->model->where($where);
            $this->applyMiniappAgentUserScope($query);
            $list = $query->order($sort, $order)->paginate($limit);

            $items = $list->items();
            $userIds = [];
            $parentIds = [];
            foreach ($items as $row) {
                $userIds[] = (int)$row['id'];
                if (!empty($row['parent_id'])) {
                    $parentIds[] = (int)$row['parent_id'];
                }
            }
            $rechargeAddressMap = $this->getRechargeAddressMap($userIds);
            $parentAccountMap = $this->getParentAccountMap($parentIds);

            foreach ($items as $row) {
                $parentAccount = $parentAccountMap[(int)($row['parent_id'] ?? 0)] ?? '--';
                $row['display_name'] = $parentAccount;
                $row['parent_account'] = $parentAccount;
                $row['recharge_address'] = $rechargeAddressMap[(int)$row['id']] ?? '';
                $row['agent_enabled'] = (int)($row['show_td'] ?? 0);
            }

            return json([
                'total' => $list->total(),
                'rows'  => $items,
            ]);
        }

        return $this->view->fetch();
    }

    public function edit($ids = null)
    {
        $row = $this->model->get($ids);
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        $this->assertMiniappAgentCanAccessUser((int)$row['id']);

        if (!$this->request->isPost()) {
            $row['parent_account'] = $this->getParentAccount((int)($row['parent_id'] ?? 0));
            $row['recharge_address'] = $this->getUserRechargeAddress((int)$row['id']);
            $this->view->assign('row', $row);
            return $this->view->fetch();
        }

        $params = $this->request->post('row/a');
        if (!$params) {
            $this->error(__('Parameter %s can not be empty', ''));
        }

        $saveData = $this->normalizeSettingParams($params);
        Db::startTrans();
        try {
            $result = $row->allowField([
                'template_name',
                'dispatch_order',
                'commission_rate',
                'fixed_commission',
                'dispatch_amount',
                'show_td',
            ])->save($saveData);
            if ($result === false) {
                throw new \RuntimeException(__('No rows were updated'));
            }
            $this->saveRechargeAddress((int)$row['id'], (string)$saveData['recharge_address']);
            Db::commit();
        } catch (\Throwable $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }

        $this->success();
    }

    protected function normalizeSettingParams($params)
    {
        return [
            'template_name'    => isset($params['template_name']) ? trim((string)$params['template_name']) : '',
            'dispatch_order'   => $this->normalizeSequenceValue($params['dispatch_order'] ?? '', 'int'),
            'commission_rate'  => $this->normalizeSequenceValue($params['commission_rate'] ?? '', 'number'),
            'fixed_commission' => $this->normalizeSequenceValue($params['fixed_commission'] ?? '', 'number'),
            'dispatch_amount'  => $this->normalizeSequenceValue($params['dispatch_amount'] ?? '', 'number'),
            'show_td'          => !empty($params['show_td']) ? 1 : 0,
            'recharge_address' => trim((string)($params['recharge_address'] ?? '')),
        ];
    }

    protected function buildParentDisplayName($row)
    {
        $parentUsername = trim((string)($row['parent_username'] ?? ''));
        if ($parentUsername !== '') {
            return $parentUsername;
        }
        $parentNickname = trim((string)($row['parent_nickname'] ?? ''));
        if ($parentNickname !== '') {
            return $parentNickname;
        }
        $parentTel = trim((string)($row['parent_tel'] ?? ''));
        if ($parentTel !== '') {
            return $parentTel;
        }
        return '--';
    }

    protected function getParentAccountMap(array $parentIds)
    {
        $parentIds = array_values(array_unique(array_filter(array_map('intval', $parentIds))));
        if (!$parentIds) {
            return [];
        }

        $rows = Db::name('miniapp_user')
            ->where('id', 'in', $parentIds)
            ->field('id,tel,username,nickname')
            ->select();

        $map = [];
        foreach ($rows as $row) {
            $map[(int)$row['id']] = $this->buildParentDisplayName([
                'parent_username' => $row['username'] ?? '',
                'parent_nickname' => $row['nickname'] ?? '',
                'parent_tel'      => $row['tel'] ?? '',
            ]);
        }

        return $map;
    }

    protected function getParentAccount($parentId)
    {
        $parentId = (int)$parentId;
        if ($parentId <= 0) {
            return '--';
        }

        $map = $this->getParentAccountMap([$parentId]);
        return $map[$parentId] ?? '--';
    }

    protected function getRechargeAddressMap(array $userIds)
    {
        $userIds = array_values(array_unique(array_filter(array_map('intval', $userIds))));
        if (!$userIds) {
            return [];
        }

        $rows = Db::name('miniapp_pay_config')
            ->where('user_id', 'in', $userIds)
            ->where('status', 1)
            ->order('sort desc,id desc')
            ->field('user_id,usercode')
            ->select();

        $map = [];
        foreach ($rows as $row) {
            $userId = (int)$row['user_id'];
            if (!isset($map[$userId])) {
                $map[$userId] = (string)$row['usercode'];
            }
        }

        return $map;
    }

    protected function getUserRechargeAddress($userId)
    {
        if ($userId <= 0) {
            return '';
        }

        $row = Db::name('miniapp_pay_config')
            ->where('user_id', $userId)
            ->where('status', 1)
            ->order('sort desc,id desc')
            ->field('usercode')
            ->find();

        return $row ? (string)$row['usercode'] : '';
    }

    protected function saveRechargeAddress($userId, $rechargeAddress)
    {
        $userId = (int)$userId;
        if ($userId <= 0) {
            return;
        }

        $now = time();
        $existing = Db::name('miniapp_pay_config')
            ->where('user_id', $userId)
            ->order('id desc')
            ->find();

        if ($rechargeAddress === '') {
            if ($existing) {
                Db::name('miniapp_pay_config')->where('id', (int)$existing['id'])->update([
                    'status' => 0,
                    'update_time' => $now,
                ]);
            }
            return;
        }

        if ($existing) {
            Db::name('miniapp_pay_config')->where('id', (int)$existing['id'])->update([
                'usercode' => $rechargeAddress,
                'status' => 1,
                'update_time' => $now,
            ]);
            return;
        }

        Db::name('miniapp_pay_config')->insert([
            'user_id' => $userId,
            'usercode' => $rechargeAddress,
            'type' => self::PAY_CONFIG_DEFAULT_TYPE,
            'status' => 1,
            'sort' => 100,
            'create_time' => $now,
            'update_time' => $now,
        ]);
    }

    protected function normalizeSequenceValue($value, $type = 'number')
    {
        $value = trim((string)$value);
        if ($value === '') {
            return '';
        }

        $segments = array_values(array_filter(array_map('trim', explode('/', $value)), function ($item) {
            return $item !== '';
        }));

        if (!$segments) {
            return '';
        }

        $normalized = [];
        foreach ($segments as $segment) {
            if ($type === 'int') {
                if (!preg_match('/^\d+$/', $segment)) {
                    $this->error(__('Sequence only supports non-negative integers'));
                }
                $normalized[] = (string)((int)$segment);
                continue;
            }

            if (!is_numeric($segment)) {
                $this->error(__('Sequence only supports numeric values'));
            }

            $number = round((float)$segment, 2);
            if ($number < 0) {
                $this->error(__('Sequence only supports non-negative values'));
            }
            $normalized[] = rtrim(rtrim(sprintf('%.2f', $number), '0'), '.');
        }

        return implode('/', $normalized);
    }

    public function selectpage()
    {
        if ($this->isMiniappAgentAdmin()) {
            $this->error(__('You have no permission'), '');
        }
        return parent::selectpage();
    }

    public function recharge($ids = null)
    {
        $row = $this->model->get($ids);
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        $this->assertMiniappAgentCanAccessUser((int)$row['id']);

        if (!$this->request->isPost()) {
            $this->view->assign('row', $row);
            return $this->view->fetch();
        }

        $params = $this->request->post('row/a');
        if (!$params) {
            $this->error(__('Parameter %s can not be empty', ''));
        }

        $amount = round((float)($params['amount'] ?? 0), 2);
        $remark = trim((string)($params['remark'] ?? ''));
        if ($amount <= 0) {
            $this->error(__('Recharge amount must be greater than 0'));
        }

        $now = time();
        $orderNo = 'RC' . date('ymdHis') . mt_rand(1000, 9999);

        Db::startTrans();
        try {
            $latest = $this->model->lock(true)->find($row['id']);
            if (!$latest) {
                throw new \RuntimeException(__('No Results were found'));
            }

            $newBalance = round((float)$latest['balance'] + $amount, 2);
            $latest->save([
                'balance'     => $newBalance,
                'update_time' => $now,
            ]);

            Db::name('miniapp_finance_log')->insert([
                'user_id'          => (int)$latest['id'],
                'uid'              => (int)$latest['id'],
                'sid'              => (int)$latest['id'],
                'oid'              => $orderNo,
                'num'              => $amount,
                'balance'          => $newBalance,
                'addtime'          => $now,
                'status'           => 1,
                'type'             => self::FINANCE_TYPE_ADMIN_RECHARGE,
                'amount'           => $amount,
                'balance_after'    => $newBalance,
                'related_order_no' => $orderNo,
                'remark'           => $remark !== '' ? $remark : 'admin recharge',
                'create_time'      => $now,
            ]);

            Db::commit();
        } catch (\Throwable $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }

        $this->success();
    }

    public function withdraw($ids = null)
    {
        $row = $this->model->get($ids);
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        $this->assertMiniappAgentCanAccessUser((int)$row['id']);

        if (!$this->request->isPost()) {
            $this->view->assign('row', $row);
            return $this->view->fetch();
        }

        $params = $this->request->post('row/a');
        if (!$params) {
            $this->error(__('Parameter %s can not be empty', ''));
        }

        $amount = round((float)($params['amount'] ?? 0), 2);
        $type = trim((string)($params['type'] ?? 'admin'));
        $remark = trim((string)($params['remark'] ?? ''));
        if ($amount <= 0) {
            $this->error(__('Withdraw amount must be greater than 0'));
        }

        $now = time();
        $withdrawNo = 'WD' . date('ymdHis') . mt_rand(1000, 9999);

        Db::startTrans();
        try {
            $latest = $this->model->lock(true)->find($row['id']);
            if (!$latest) {
                throw new \RuntimeException(__('No Results were found'));
            }

            $balance = round((float)$latest['balance'], 2);
            if ($balance < $amount) {
                throw new \RuntimeException(__('Insufficient balance'));
            }

            $newBalance = round($balance - $amount, 2);
            $latest->save([
                'balance'     => $newBalance,
                'update_time' => $now,
            ]);

            Db::name('miniapp_withdraw')->insert([
                'user_id'     => (int)$latest['id'],
                'withdraw_no' => $withdrawNo,
                'type'        => $type !== '' ? $type : 'admin',
                'amount'      => $amount,
                'status'      => 1,
                'create_time' => $now,
                'update_time' => $now,
            ]);

            Db::name('miniapp_finance_log')->insert([
                'user_id'          => (int)$latest['id'],
                'uid'              => (int)$latest['id'],
                'sid'              => (int)$latest['id'],
                'oid'              => $withdrawNo,
                'num'              => -$amount,
                'balance'          => $newBalance,
                'addtime'          => $now,
                'status'           => 1,
                'type'             => 7,
                'amount'           => -$amount,
                'balance_after'    => $newBalance,
                'related_order_no' => $withdrawNo,
                'remark'           => $remark !== '' ? $remark : 'admin withdraw',
                'create_time'      => $now,
            ]);

            Db::commit();
        } catch (\Throwable $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }

        $this->success();
    }
}
