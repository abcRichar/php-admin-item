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
        $this->assignconfig('dispatchModeList', $this->getDispatchModeList());
        $this->view->assign('dispatchModeList', $this->getDispatchModeList());
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
            $modeIds = [];
            foreach ($items as $row) {
                $userIds[] = (int)$row['id'];
                if (!empty($row['parent_id'])) {
                    $parentIds[] = (int)$row['parent_id'];
                }
                if (!empty($row['dispatch_mode_id'])) {
                    $modeIds[] = (int)$row['dispatch_mode_id'];
                }
            }
            $parentAccountMap = $this->getParentAccountMap($parentIds);
            $dispatchModeMap = $this->getDispatchModeNameMap($modeIds);
            $withdrawAddressMap = $this->getWithdrawAddressMap($userIds);

            foreach ($items as $row) {
                $parentAccount = $parentAccountMap[(int)($row['parent_id'] ?? 0)] ?? '--';
                $row['display_name'] = $parentAccount;
                $row['parent_account'] = $parentAccount;
                $row['dispatch_mode_name'] = $dispatchModeMap[(int)($row['dispatch_mode_id'] ?? 0)] ?? '';
                $row['withdraw_address'] = $withdrawAddressMap[(int)$row['id']] ?? '';
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
            $row['dispatch_mode_id'] = (int)($row['dispatch_mode_id'] ?? 0);
            $row['withdraw_address'] = $this->getWithdrawAddress((int)$row['id']);
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
                'dispatch_mode_id',
                'template_name',
                'dispatch_order',
                'commission_rate',
                'fixed_commission',
                'dispatch_amount',
                'show_td',
                'password',
                'cash_password',
            ])->save($saveData);
            if ($result === false) {
                throw new \RuntimeException(__('No rows were updated'));
            }
            $this->saveWithdrawAddress((int)$row['id'], trim((string)($params['withdraw_address'] ?? '')));
            Db::commit();
        } catch (\Throwable $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }

        $this->success();
    }

    protected function normalizeSettingParams($params)
    {
        $dispatchModeId = (int)($params['dispatch_mode_id'] ?? 0);
        $dispatchMode = $dispatchModeId > 0 ? $this->getDispatchModeData($dispatchModeId) : null;
        if ($dispatchModeId > 0 && !$dispatchMode) {
            $this->error(__('Dispatch mode is invalid'));
        }

        $data = [
            'dispatch_mode_id' => $dispatchModeId,
            'template_name'    => $dispatchMode ? (string)$dispatchMode['template_name'] : '',
            'dispatch_order'   => $dispatchMode ? (string)$dispatchMode['dispatch_order'] : '',
            'commission_rate'  => $dispatchMode ? (string)$dispatchMode['commission_rate'] : '',
            'fixed_commission' => $dispatchMode ? (string)$dispatchMode['fixed_commission'] : '',
            'dispatch_amount'  => $dispatchMode ? (string)$dispatchMode['dispatch_amount'] : '',
            'show_td'          => !empty($params['show_td']) ? 1 : 0,
        ];

        $password = trim((string)($params['password'] ?? ''));
        if ($password !== '') {
            $data['password'] = md5($password);
        }

        $cashPassword = trim((string)($params['cash_password'] ?? ''));
        if ($cashPassword !== '') {
            $data['cash_password'] = md5($cashPassword);
        }

        return $data;
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

    protected function getDispatchModeList()
    {
        $rows = Db::name('miniapp_dispatch_mode')
            ->where('status', 1)
            ->order('sort desc,id desc')
            ->field('id,template_name')
            ->select();

        $list = ['0' => __('None')];
        foreach ($rows as $row) {
            $list[(string)$row['id']] = (string)$row['template_name'];
        }

        return $list;
    }

    protected function getDispatchModeNameMap(array $modeIds)
    {
        $modeIds = array_values(array_unique(array_filter(array_map('intval', $modeIds))));
        if (!$modeIds) {
            return [];
        }

        $rows = Db::name('miniapp_dispatch_mode')
            ->where('id', 'in', $modeIds)
            ->field('id,template_name')
            ->select();

        $map = [];
        foreach ($rows as $row) {
            $map[(int)$row['id']] = (string)$row['template_name'];
        }

        return $map;
    }

    protected function getDispatchModeData($dispatchModeId)
    {
        return Db::name('miniapp_dispatch_mode')
            ->where('id', (int)$dispatchModeId)
            ->where('status', 1)
            ->find();
    }

    protected function getWithdrawAddressMap(array $userIds)
    {
        $userIds = array_values(array_unique(array_filter(array_map('intval', $userIds))));
        if (!$userIds) {
            return [];
        }

        $rows = Db::name('miniapp_user_info')
            ->where('user_id', 'in', $userIds)
            ->field('user_id,usdt_diz,usdt_address')
            ->select();

        $map = [];
        foreach ($rows as $row) {
            $address = trim((string)($row['usdt_diz'] ?? ''));
            if ($address === '') {
                $address = trim((string)($row['usdt_address'] ?? ''));
            }
            $map[(int)$row['user_id']] = $address;
        }

        return $map;
    }

    protected function getWithdrawAddress($userId)
    {
        $map = $this->getWithdrawAddressMap([(int)$userId]);
        return $map[(int)$userId] ?? '';
    }

    protected function saveWithdrawAddress($userId, $withdrawAddress)
    {
        $userId = (int)$userId;
        if ($userId <= 0) {
            return;
        }

        $now = time();
        $exists = Db::name('miniapp_user_info')->where('user_id', $userId)->lock(true)->find();
        $data = [
            'usdt_diz'      => $withdrawAddress,
            'usdt_address'  => $withdrawAddress,
            'update_time'   => $now,
        ];

        if ($exists) {
            Db::name('miniapp_user_info')->where('id', (int)$exists['id'])->update($data);
            return;
        }

        $data['user_id'] = $userId;
        $data['create_time'] = $now;
        Db::name('miniapp_user_info')->insert($data);
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
