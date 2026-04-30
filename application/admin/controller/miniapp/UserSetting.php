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
            $list = $this->model
                ->where($where)
                ->order($sort, $order)
                ->paginate($limit);

            foreach ($list as $row) {
                $row['display_name'] = (string)($row['username'] ?: $row['nickname'] ?: $row['tel']);
            }

            return json([
                'total' => $list->total(),
                'rows'  => $list->items(),
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

        if (!$this->request->isPost()) {
            $this->view->assign('row', $row);
            return $this->view->fetch();
        }

        $params = $this->request->post('row/a');
        if (!$params) {
            $this->error(__('Parameter %s can not be empty', ''));
        }

        $saveData = $this->normalizeSettingParams($params);
        $result = $row->allowField([
            'template_name',
            'dispatch_order',
            'commission_rate',
            'fixed_commission',
            'dispatch_amount',
        ])->save($saveData);

        if ($result === false) {
            $this->error(__('No rows were updated'));
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
        ];
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
        return parent::selectpage();
    }

    public function recharge($ids = null)
    {
        $row = $this->model->get($ids);
        if (!$row) {
            $this->error(__('No Results were found'));
        }

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
