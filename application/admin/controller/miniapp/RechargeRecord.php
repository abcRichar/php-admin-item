<?php

namespace app\admin\controller\miniapp;

use app\common\controller\Backend;
use think\Db;

/**
 * 充值记录
 *
 * @icon fa fa-credit-card
 */
class RechargeRecord extends Backend
{
    protected $model = null;
    protected $searchFields = 'id,order_no,remark,tel,username,nickname';
    protected $noNeedRight = ['approve', 'reject'];

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\MiniappFinanceLog;
        $this->assignconfig('statusList', $this->getAuditStatusList());
    }

    public function index()
    {
        $this->request->filter(['strip_tags', 'trim']);
        if ($this->request->isAjax()) {
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }

            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $query = Db::name('miniapp_admin_balance_audit')
                ->alias('record')
                ->join('fa_miniapp_user user', 'user.id = record.user_id', 'LEFT')
                ->field('record.id,record.user_id,record.admin_id,record.audit_admin_id,record.type,record.amount,record.order_no,record.withdraw_type,record.remark,record.status,record.audit_time,record.create_time,record.update_time,user.tel,user.username,user.nickname')
                ->where('record.type', UserSetting::AUDIT_TYPE_RECHARGE)
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
        $this->changeRechargeStatus($ids, 1);
    }

    public function reject($ids = null)
    {
        $this->changeRechargeStatus($ids, 2);
    }

    protected function changeRechargeStatus($ids, $targetStatus)
    {
        if (!$this->request->isPost()) {
            $this->error(__('Invalid parameters'));
        }

        $now = time();
        Db::startTrans();
        try {
            $audit = Db::name('miniapp_admin_balance_audit')
                ->where('id', (int)$ids)
                ->where('type', UserSetting::AUDIT_TYPE_RECHARGE)
                ->lock(true)
                ->find();
            if (!$audit) {
                throw new \RuntimeException(__('No Results were found'));
            }
            $this->assertCanAuditBalanceAudit($audit);
            if ((int)$audit['status'] !== 0) {
                throw new \RuntimeException(__('Recharge record already audited'));
            }

            $user = Db::name('miniapp_user')->where('id', (int)$audit['user_id'])->lock(true)->find();
            if (!$user) {
                throw new \RuntimeException(__('No Results were found'));
            }

            $amount = round((float)$audit['amount'], 2);
            if ((int)$targetStatus === 1) {
                $newBalance = round((float)$user['balance'] + $amount, 2);
                Db::name('miniapp_user')->where('id', (int)$user['id'])->update([
                    'balance' => $newBalance,
                    'update_time' => $now,
                ]);
                Db::name('miniapp_finance_log')->insert([
                    'user_id'          => (int)$user['id'],
                    'uid'              => (int)$user['id'],
                    'sid'              => (int)$user['id'],
                    'oid'              => (string)$audit['order_no'],
                    'num'              => $amount,
                    'balance'          => $newBalance,
                    'addtime'          => $now,
                    'status'           => 1,
                    'type'             => UserSetting::FINANCE_TYPE_ADMIN_RECHARGE,
                    'amount'           => $amount,
                    'balance_after'    => $newBalance,
                    'related_order_no' => (string)$audit['order_no'],
                    'remark'           => (string)($audit['remark'] ?: 'admin recharge approve'),
                    'create_time'      => $now,
                ]);
            }

            Db::name('miniapp_admin_balance_audit')->where('id', (int)$audit['id'])->update([
                'status' => (int)$targetStatus,
                'audit_time' => $now,
                'update_time' => $now,
            ]);

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

        $submitAdminId = (int)($audit['admin_id'] ?? 0);
        if ($submitAdminId > 0 && $submitAdminId === $this->getCurrentAdminId()) {
            return true;
        }

        $auditAdminId = (int)($audit['audit_admin_id'] ?? 0);
        return $auditAdminId > 0 && $auditAdminId === $this->getCurrentAdminId();
    }

    protected function getAuditStatusList()
    {
        return [
            '0' => __('Pending'),
            '1' => __('Approved'),
            '2' => __('Rejected'),
        ];
    }
}
