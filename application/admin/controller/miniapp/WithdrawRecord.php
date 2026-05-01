<?php

namespace app\admin\controller\miniapp;

use app\common\controller\Backend;
use think\Db;

/**
 * 提现记录
 *
 * @icon fa fa-bank
 */
class WithdrawRecord extends Backend
{
    protected $model = null;
    protected $searchFields = 'id,withdraw_no,type,tel,username,nickname';

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\MiniappWithdraw;
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
            $query = $this->model
                ->alias('record')
                ->join('fa_miniapp_user user', 'user.id = record.user_id', 'LEFT')
                ->field('record.*,user.tel,user.username,user.nickname')
                ->where($where);
            $this->applyMiniappAgentUserScope($query, 'user');
            $list = $query->order($sort, $order)->paginate($limit);

            foreach ($list as $row) {
                $row['display_name'] = (string)($row['username'] ?: $row['nickname'] ?: $row['tel'] ?: ('UID:' . $row['user_id']));
            }

            return json([
                'total' => $list->total(),
                'rows'  => $list->items(),
            ]);
        }

        return $this->view->fetch();
    }

    public function approve($ids = null)
    {
        $this->changeWithdrawStatus($ids, 1);
    }

    public function reject($ids = null)
    {
        $this->changeWithdrawStatus($ids, 2);
    }

    protected function changeWithdrawStatus($ids, $targetStatus)
    {
        if (!$this->request->isPost()) {
            $this->error(__('Invalid parameters'));
        }

        $row = $this->model->get($ids);
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        $this->assertMiniappAgentCanAccessUser((int)$row['user_id']);
        if ((int)$row['status'] !== 0) {
            $this->error(__('Withdraw record already audited'));
        }

        $now = time();
        Db::startTrans();
        try {
            $latest = Db::name('miniapp_withdraw')->where('id', (int)$row['id'])->lock(true)->find();
            if (!$latest) {
                throw new \RuntimeException(__('No Results were found'));
            }
            if ((int)$latest['status'] !== 0) {
                throw new \RuntimeException(__('Withdraw record already audited'));
            }

            $user = Db::name('miniapp_user')->where('id', (int)$latest['user_id'])->lock(true)->find();
            if (!$user) {
                throw new \RuntimeException(__('No Results were found'));
            }

            $amount = round((float)$latest['amount'], 2);
            $freezeBalance = round((float)($user['freeze_balance'] ?? 0), 2);
            if ($freezeBalance < $amount) {
                throw new \RuntimeException(__('Freeze balance insufficient'));
            }

            $updateUserData = [
                'freeze_balance' => round($freezeBalance - $amount, 2),
                'update_time' => $now,
            ];

            if ((int)$targetStatus === 2) {
                $updateUserData['balance'] = round((float)$user['balance'] + $amount, 2);
            }

            Db::name('miniapp_user')->where('id', (int)$user['id'])->update($updateUserData);
            Db::name('miniapp_withdraw')->where('id', (int)$latest['id'])->update([
                'status' => (int)$targetStatus,
                'update_time' => $now,
            ]);

            if ((int)$targetStatus === 1) {
                Db::name('miniapp_finance_log')->insert([
                    'user_id' => (int)$user['id'],
                    'uid' => (int)$user['id'],
                    'sid' => (int)$user['id'],
                    'oid' => (string)$latest['withdraw_no'],
                    'num' => -$amount,
                    'balance' => round((float)$user['balance'], 2),
                    'addtime' => $now,
                    'status' => 1,
                    'type' => 7,
                    'amount' => -$amount,
                    'balance_after' => round((float)$user['balance'], 2),
                    'related_order_no' => (string)$latest['withdraw_no'],
                    'remark' => 'withdraw approve',
                    'create_time' => $now,
                ]);
            } else {
                $balanceAfter = round((float)$updateUserData['balance'], 2);
                Db::name('miniapp_finance_log')->insert([
                    'user_id' => (int)$user['id'],
                    'uid' => (int)$user['id'],
                    'sid' => (int)$user['id'],
                    'oid' => (string)$latest['withdraw_no'],
                    'num' => $amount,
                    'balance' => $balanceAfter,
                    'addtime' => $now,
                    'status' => 1,
                    'type' => 7,
                    'amount' => $amount,
                    'balance_after' => $balanceAfter,
                    'related_order_no' => (string)$latest['withdraw_no'],
                    'remark' => 'withdraw reject refund',
                    'create_time' => $now,
                ]);
            }

            Db::commit();
        } catch (\Throwable $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }

        $this->success();
    }
}
