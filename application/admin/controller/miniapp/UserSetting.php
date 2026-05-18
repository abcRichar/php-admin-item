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
    protected $noNeedRight = ['selectpage', 'create_subordinate'];
    const FINANCE_TYPE_ADMIN_RECHARGE = 8;
    const AUDIT_TYPE_RECHARGE = 1;
    const AUDIT_TYPE_WITHDRAW = 2;
    const PAY_CONFIG_DEFAULT_TYPE = 'USDT-TRC20';

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\MiniappUser;
        $this->assignconfig('statusList', $this->model->getStatusList());
        $this->assignconfig('dispatchModeList', $this->getDispatchModeList());
        $this->assignconfig('isMiniappAgent', $this->isMiniappAgentAdmin() ? 1 : 0);
        $this->assignconfig('canCreateSubordinate', !$this->auth->isSuperAdmin() ? 1 : 0);
        $this->view->assign('dispatchModeList', $this->getDispatchModeList());
        $this->view->assign('canCreateSubordinate', !$this->auth->isSuperAdmin() ? 1 : 0);
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
            $inviteAdminAccountMap = $this->getInviteAdminAccountMap($userIds);
            $dispatchModeMap = $this->getDispatchModeNameMap($modeIds);
            $withdrawAddressMap = $this->getWithdrawAddressMap($userIds);

            foreach ($items as $row) {
                $parentAccount = $parentAccountMap[(int)($row['parent_id'] ?? 0)] ?? ($inviteAdminAccountMap[(int)$row['id']] ?? '--');
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
            $row['parent_account'] = $this->getParentAccount((int)($row['parent_id'] ?? 0), (int)$row['id']);
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
                'status',
                'task_update_status',
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

    public function create_subordinate($ids = null)
    {
        $parent = $this->resolveSubordinateParent($ids);

        if (!$this->request->isPost()) {
            $this->view->assign('parent', $parent);
            return $this->view->fetch();
        }

        $params = $this->request->post('row/a');
        if (!$params) {
            $this->error(__('Parameter %s can not be empty', ''));
        }

        $isAdminParent = isset($parent['parent_type']) && $parent['parent_type'] === 'admin';
        $data = $this->normalizeSubordinateParams($params, $isAdminParent ? 0 : (int)$parent['id']);
        $now = time();

        Db::startTrans();
        try {
            $userId = Db::name('miniapp_user')->insertGetId($data);
            Db::name('miniapp_user_info')->insert([
                'user_id'     => (int)$userId,
                'create_time' => $now,
                'update_time' => $now,
            ]);
            if ($isAdminParent) {
                Db::name('admin_miniapp_user')->insert([
                    'admin_id'    => (int)$parent['id'],
                    'user_id'     => (int)$userId,
                    'invite_code' => (string)($parent['invite_code'] ?? ''),
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
            'status'           => !empty($params['status']) ? 1 : 0,
            'task_update_status' => !empty($params['task_update_status']) ? 1 : 0,
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

    protected function resolveSubordinateParent($ids = null)
    {
        $requestedParentId = (int)($ids ?: $this->request->param('parent_id', 0));
        if (!$this->auth->isSuperAdmin() && !$this->isMiniappAgentAdmin() && $requestedParentId <= 0) {
            return $this->getCurrentAdminAsSubordinateParent();
        }

        if ($this->isMiniappAgentAdmin()) {
            $agentUserId = $this->getMiniappAgentUserId();
            $parentId = $requestedParentId > 0 ? $requestedParentId : $agentUserId;
            if ($parentId !== $agentUserId) {
                $this->assertMiniappAgentCanAccessUser($parentId);
            }
        } else {
            $parentId = $requestedParentId;
        }

        if ($parentId <= 0) {
            $this->error(__('Please select parent account'));
        }

        $parent = Db::name('miniapp_user')
            ->where('id', $parentId)
            ->where('status', 1)
            ->find();
        if (!$parent) {
            $this->error(__('Parent account is invalid'));
        }
        if (!$this->auth->isSuperAdmin() && !$this->isMiniappAgentAdmin()) {
            $this->assertMiniappAgentCanAccessUser((int)$parent['id']);
        }

        return $parent;
    }

    protected function getCurrentAdminAsSubordinateParent()
    {
        $adminId = $this->getCurrentAdminId();
        if ($adminId <= 0) {
            $this->error(__('Parent account is invalid'));
        }

        $admin = Db::name('admin')
            ->where('id', $adminId)
            ->where('status', 'normal')
            ->field('id,username,nickname,mobile,invite_code')
            ->find();
        if (!$admin) {
            $this->error(__('Parent account is invalid'));
        }

        return [
            'id'          => (int)$admin['id'],
            'username'    => (string)$admin['username'],
            'nickname'    => (string)$admin['nickname'],
            'tel'         => (string)$admin['mobile'],
            'invite_code' => (string)($admin['invite_code'] ?? ''),
            'parent_type' => 'admin',
        ];
    }

    protected function normalizeSubordinateParams($params, $parentId)
    {
        $tel = trim((string)($params['tel'] ?? ''));
        $areaCode = trim((string)($params['area_code'] ?? '+86'));
        $password = trim((string)($params['password'] ?? ''));
        $cashPassword = trim((string)($params['cash_password'] ?? ''));
        $username = trim((string)($params['username'] ?? ''));
        $nickname = trim((string)($params['nickname'] ?? ''));
        $showTd = !empty($params['show_td']) ? 1 : 0;
        $status = isset($params['status']) ? (int)$params['status'] : 1;

        if ($tel === '' || $password === '') {
            $this->error(__('Tel and password are required'));
        }
        if (strlen($tel) > 32) {
            $this->error(__('Tel is too long'));
        }
        if (strlen($password) < 6) {
            $this->error(__('Password must be at least 6 characters'));
        }
        if ($cashPassword !== '' && strlen($cashPassword) < 6) {
            $this->error(__('Cash password must be at least 6 characters'));
        }
        if (!in_array($status, [0, 1], true)) {
            $this->error(__('Status is invalid'));
        }
        if (Db::name('miniapp_user')->where('tel', $tel)->find()) {
            $this->error(__('Tel already exists'));
        }

        $now = time();
        return [
            'tel'             => $tel,
            'area_code'       => $areaCode !== '' ? $areaCode : '+86',
            'password'        => md5($password),
            'cash_password'   => md5($cashPassword !== '' ? $cashPassword : $password),
            'token'           => '',
            'nickname'        => $nickname !== '' ? $nickname : ('U' . substr($tel, -4)),
            'username'        => $username,
            'avatar'          => '',
            'headpic'         => '',
            'balance'         => 0,
            'freeze_balance'  => 0,
            'team_income'     => 0,
            'invite_code'     => $this->generateInviteCode($tel, $now),
            'parent_id'       => (int)$parentId,
            'level'           => 0,
            'deal_num'        => 0,
            'group_id'        => 0,
            'show_td'         => $showTd,
            'status'          => $status,
            'last_login_time' => 0,
            'last_login_ip'   => '',
            'create_time'     => $now,
            'update_time'     => $now,
        ];
    }

    protected function generateInviteCode($tel, $now)
    {
        for ($i = 0; $i < 10; $i++) {
            $code = strtoupper(substr(md5($tel . '_' . $now . '_' . mt_rand(1000, 999999)), 0, 8));
            if (!Db::name('miniapp_user')->where('invite_code', $code)->find()) {
                return $code;
            }
        }

        return strtoupper(substr(md5($tel . '_' . microtime(true)), 0, 12));
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

    protected function getParentAccount($parentId, $userId = 0)
    {
        $parentId = (int)$parentId;
        if ($parentId <= 0) {
            return $this->getInviteAdminAccount((int)$userId);
        }

        $map = $this->getParentAccountMap([$parentId]);
        return $map[$parentId] ?? '--';
    }

    protected function getInviteAdminAccountMap(array $userIds)
    {
        $userIds = array_values(array_unique(array_filter(array_map('intval', $userIds))));
        if (!$userIds) {
            return [];
        }

        try {
            $rows = Db::name('admin_miniapp_user')
                ->alias('relation')
                ->join('fa_admin admin', 'admin.id = relation.admin_id', 'LEFT')
                ->where('relation.user_id', 'in', $userIds)
                ->field('relation.user_id,admin.username,admin.nickname,admin.mobile')
                ->select();
        } catch (\Throwable $e) {
            return [];
        }

        $map = [];
        foreach ($rows as $row) {
            $account = trim((string)($row['username'] ?? ''));
            if ($account === '') {
                $account = trim((string)($row['nickname'] ?? ''));
            }
            if ($account === '') {
                $account = trim((string)($row['mobile'] ?? ''));
            }
            $map[(int)$row['user_id']] = $account !== '' ? $account : '--';
        }

        return $map;
    }

    protected function getInviteAdminAccount($userId)
    {
        $userId = (int)$userId;
        if ($userId <= 0) {
            return '--';
        }

        $map = $this->getInviteAdminAccountMap([$userId]);
        return $map[$userId] ?? '--';
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

    protected function shouldAuditBalanceOperation()
    {
        return !($this->auth && $this->auth->isSuperAdmin());
    }

    protected function getCurrentAdminParentId()
    {
        $adminId = $this->getCurrentAdminId();
        if ($adminId <= 0) {
            return 0;
        }

        return (int)Db::name('admin')
            ->where('id', $adminId)
            ->value('parent_admin_id');
    }

    protected function getBalanceAuditAdminId()
    {
        if ($this->isMiniappAgentAdmin()) {
            $agentUserId = $this->getMiniappAgentUserId();
            if ($agentUserId <= 0) {
                return 0;
            }

            $parentUserId = (int)Db::name('miniapp_user')
                ->where('id', $agentUserId)
                ->value('parent_id');
            if ($parentUserId > 0) {
                $parentAgentAdminId = (int)Db::name('admin')
                    ->where('admin_type', \app\admin\library\Auth::ADMIN_TYPE_AGENT)
                    ->where('miniapp_user_id', $parentUserId)
                    ->where('status', 'normal')
                    ->value('id');
                if ($parentAgentAdminId > 0) {
                    return $parentAgentAdminId;
                }
            }

            $inviteAdminId = (int)Db::name('admin_miniapp_user')
                ->alias('relation')
                ->join('fa_admin admin', 'admin.id = relation.admin_id', 'INNER')
                ->where('relation.user_id', $agentUserId)
                ->where('admin.status', 'normal')
                ->value('relation.admin_id');

            return $inviteAdminId > 0 ? $inviteAdminId : 0;
        }

        return 0;
    }

    protected function createBalanceAudit($userId, $type, $amount, $orderNo, $withdrawType = '', $remark = '', $status = 0)
    {
        $now = time();
        Db::name('miniapp_admin_balance_audit')->insert([
            'user_id'        => (int)$userId,
            'admin_id'       => $this->getCurrentAdminId(),
            'audit_admin_id' => $this->getBalanceAuditAdminId(),
            'type'           => (int)$type,
            'amount'         => round((float)$amount, 2),
            'order_no'       => (string)$orderNo,
            'withdraw_type'  => (string)$withdrawType,
            'remark'         => (string)$remark,
            'status'         => (int)$status,
            'audit_time'     => (int)$status === 0 ? 0 : $now,
            'create_time'    => $now,
            'update_time'    => $now,
        ]);
    }

    public function selectpage()
    {
        if (!$this->auth->isSuperAdmin()) {
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

            $needAudit = $this->shouldAuditBalanceOperation();
            if ($needAudit) {
                $this->createBalanceAudit(
                    (int)$latest['id'],
                    self::AUDIT_TYPE_RECHARGE,
                    $amount,
                    $orderNo,
                    '',
                    $remark
                );
            } else {
                $newBalance = round((float)$latest['balance'] + $amount, 2);
                $latest->save([
                    'balance'     => $newBalance,
                    'update_time' => $now,
                ]);

                $this->createBalanceAudit(
                    (int)$latest['id'],
                    self::AUDIT_TYPE_RECHARGE,
                    $amount,
                    $orderNo,
                    '',
                    $remark,
                    1
                );

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
            }

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
            $saveData = [
                'balance'     => $newBalance,
                'update_time' => $now,
            ];
            $needAudit = $this->shouldAuditBalanceOperation();
            if ($needAudit) {
                $saveData['freeze_balance'] = round((float)($latest['freeze_balance'] ?? 0) + $amount, 2);
            }
            $latest->save($saveData);

            Db::name('miniapp_withdraw')->insert([
                'user_id'     => (int)$latest['id'],
                'withdraw_no' => $withdrawNo,
                'type'        => $type !== '' ? $type : 'admin',
                'amount'      => $amount,
                'status'      => $needAudit ? 0 : 1,
                'create_time' => $now,
                'update_time' => $now,
            ]);

            $this->createBalanceAudit(
                (int)$latest['id'],
                self::AUDIT_TYPE_WITHDRAW,
                $amount,
                $withdrawNo,
                $type !== '' ? $type : 'admin',
                $remark,
                $needAudit ? 0 : 1
            );

            if (!$needAudit) {
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
            }

            Db::commit();
        } catch (\Throwable $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }

        $this->success();
    }
}
