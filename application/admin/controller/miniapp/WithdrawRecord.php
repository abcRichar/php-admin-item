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
    protected $searchFields = 'id,withdraw_no,type,withdraw_address,tel,username,nickname';
    protected $noNeedRight = ['approve', 'reject'];

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
                ->join('fa_miniapp_admin_balance_audit audit', 'audit.order_no = record.withdraw_no AND audit.type = ' . UserSetting::AUDIT_TYPE_WITHDRAW, 'LEFT')
                ->field('record.*,user.tel,user.username,user.nickname,audit.admin_id as audit_admin_submit_id,audit.audit_admin_id,audit.status as audit_status')
                ->where($where);
            $this->applyMiniappAgentUserScope($query, 'user');
            $list = $query->order($sort, $order)->paginate($limit);

            $items = $list->items();
            foreach ($items as &$row) {
                $row['display_name'] = (string)($row['username'] ?: $row['nickname'] ?: $row['tel'] ?: ('UID:' . $row['user_id']));
                $row['can_audit'] = $this->canAuditBalanceAudit($row) ? 1 : 0;
            }
            unset($row);

            return json([
                'total' => $list->total(),
                'rows'  => $items,
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

            $audit = Db::name('miniapp_admin_balance_audit')
                ->where('type', UserSetting::AUDIT_TYPE_WITHDRAW)
                ->where('order_no', (string)$latest['withdraw_no'])
                ->lock(true)
                ->find();
            if ($audit) {
                $this->assertCanAuditBalanceAudit($audit);
                if ((int)$audit['status'] !== 0) {
                    throw new \RuntimeException(__('Withdraw record already audited'));
                }
            }

            $user = Db::name('miniapp_user')->where('id', (int)$latest['user_id'])->lock(true)->find();
            if (!$user) {
                throw new \RuntimeException(__('No Results were found'));
            }

            $amount = round((float)$latest['amount'], 2);
            $updateUserData = [
                'update_time' => $now,
            ];

            if ((int)$targetStatus === 1) {
                $balance = round((float)$user['balance'], 2);
                if ($balance < $amount) {
                    throw new \RuntimeException(__('Insufficient balance'));
                }
                $updateUserData['balance'] = round($balance - $amount, 2);
            }

            Db::name('miniapp_user')->where('id', (int)$user['id'])->update($updateUserData);
            Db::name('miniapp_withdraw')->where('id', (int)$latest['id'])->update([
                'status' => (int)$targetStatus,
                'update_time' => $now,
            ]);
            if ($audit) {
                Db::name('miniapp_admin_balance_audit')->where('id', (int)$audit['id'])->update([
                    'status' => (int)$targetStatus,
                    'audit_time' => $now,
                    'update_time' => $now,
                ]);
            }

            if ((int)$targetStatus === 1) {
                $balanceAfter = round((float)$updateUserData['balance'], 2);
                Db::name('miniapp_finance_log')->insert([
                    'user_id' => (int)$user['id'],
                    'uid' => (int)$user['id'],
                    'sid' => (int)$user['id'],
                    'oid' => (string)$latest['withdraw_no'],
                    'num' => -$amount,
                    'balance' => $balanceAfter,
                    'addtime' => $now,
                    'status' => 1,
                    'type' => 7,
                    'amount' => -$amount,
                    'balance_after' => $balanceAfter,
                    'related_order_no' => (string)$latest['withdraw_no'],
                    'remark' => 'withdraw approve',
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

    protected function assertCanAuditBalanceAudit($audit)
    {
        if ($this->canAuditBalanceAudit($audit)) {
            return;
        }

        $this->error(__('You have no permission'), '');
    }

    protected function canAuditBalanceAudit($audit)
    {
        if ($this->auth && $this->auth->isSuperAdmin()) {
            return true;
        }

        $submitAdminId = (int)($audit['audit_admin_submit_id'] ?? $audit['admin_id'] ?? 0);
        if ($submitAdminId > 0 && $submitAdminId === $this->getCurrentAdminId()) {
            return true;
        }

        $auditAdminId = (int)($audit['audit_admin_id'] ?? 0);
        return $auditAdminId > 0 && $auditAdminId === $this->getCurrentAdminId();
    }
}
