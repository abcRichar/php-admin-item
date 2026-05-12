<?php

namespace app\admin\controller\auth;

use app\admin\model\AuthGroup;
use app\admin\model\AuthGroupAccess;
use app\common\controller\Backend;
use fast\Random;
use fast\Tree;
use think\Db;
use think\Validate;

/**
 * 管理员管理
 *
 * @icon   fa fa-users
 * @remark 一个管理员可以有多个角色组,左侧的菜单根据管理员所拥有的权限进行生成
 */
class Admin extends Backend
{

    /**
     * @var \app\admin\model\Admin
     */
    protected $model = null;
    protected $selectpageFields = 'id,username,nickname,avatar';
    protected $searchFields = 'id,username,nickname';
    protected $childrenGroupIds = [];
    protected $childrenAdminIds = [];

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('Admin');

        $this->childrenAdminIds = $this->getManageableAdminIds();
        if (!$this->childrenAdminIds) {
            $this->childrenAdminIds = [0];
        }
        $this->childrenGroupIds = $this->auth->getChildrenGroupIds($this->auth->isSuperAdmin());

        $groupList = collection(AuthGroup::where('id', 'in', $this->childrenGroupIds)->select())->toArray();

        Tree::instance()->init($groupList);
        $groupdata = [];
        if ($this->auth->isSuperAdmin()) {
            $result = Tree::instance()->getTreeList(Tree::instance()->getTreeArray(0));
            foreach ($result as $k => $v) {
                $groupdata[$v['id']] = $v['name'];
            }
        } else {
            $result = [];
            $groups = $this->auth->getGroups();
            foreach ($groups as $m => $n) {
                $childlist = Tree::instance()->getTreeList(Tree::instance()->getTreeArray($n['id']));
                $temp = [];
                foreach ($childlist as $k => $v) {
                    $temp[$v['id']] = $v['name'];
                }
                $result[__($n['name'])] = $temp;
            }
            $groupdata = $result;
        }

        $this->view->assign('groupdata', $groupdata);
        $this->view->assign('parentAdminList', $this->getParentAdminList());
        $this->view->assign('canSelectParentAdmin', $this->auth->isSuperAdmin());
        $this->view->assign('defaultParentAdminId', $this->auth->isSuperAdmin() ? 0 : (int)$this->auth->id);
        $this->view->assign('defaultParentAdminText', $this->auth->isSuperAdmin() ? __('No parent admin') : $this->auth->username);
        $this->assignconfig("admin", ['id' => $this->auth->id]);
    }

    /**
     * 查看
     */
    public function index()
    {
        //设置过滤方法
        $this->request->filter(['strip_tags', 'trim']);
        if ($this->request->isAjax()) {
            //如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }
            $childrenGroupIds = $this->childrenGroupIds;
            $groupName = AuthGroup::where('id', 'in', $childrenGroupIds)
                ->column('id,name');
            $authGroupList = AuthGroupAccess::where('group_id', 'in', $childrenGroupIds)
                ->field('uid,group_id')
                ->select();

            $adminGroupName = [];
            foreach ($authGroupList as $k => $v) {
                if (isset($groupName[$v['group_id']])) {
                    $adminGroupName[$v['uid']][$v['group_id']] = $groupName[$v['group_id']];
                }
            }
            $groups = $this->auth->getGroups();
            foreach ($groups as $m => $n) {
                $adminGroupName[$this->auth->id][$n['id']] = $n['name'];
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();

            $list = $this->model
                ->where($where)
                ->where('id', 'in', $this->childrenAdminIds)
                ->field(['password', 'salt', 'token'], true)
                ->order($sort, $order)
                ->paginate($limit);

            $parentAdminIds = [];
            foreach ($list->items() as $item) {
                if (!empty($item['parent_admin_id'])) {
                    $parentAdminIds[] = (int)$item['parent_admin_id'];
                }
            }
            $parentAdminMap = $this->getParentAdminMap($parentAdminIds);
            foreach ($list as $k => &$v) {
                $groups = isset($adminGroupName[$v['id']]) ? $adminGroupName[$v['id']] : [];
                $v['groups'] = implode(',', array_keys($groups));
                $v['groups_text'] = implode(',', array_values($groups));
                $v['parent_admin_text'] = $parentAdminMap[(int)($v['parent_admin_id'] ?? 0)] ?? __('No parent admin');
                $v['invite_code'] = $this->ensureAdminInviteCode($v);
            }
            unset($v);
            $result = array("total" => $list->total(), "rows" => $list->items());

            return json($result);
        }
        return $this->view->fetch();
    }

    /**
     * 添加
     */
    public function add()
    {
        if ($this->request->isPost()) {
            $this->token();
            $params = $this->request->post("row/a");
            if ($params) {
                Db::startTrans();
                try {
                    if (!Validate::is($params['password'], '\S{6,30}')) {
                        exception(__("Please input correct password"));
                    }
                    $params['salt'] = Random::alnum();
                    $params['password'] = $this->auth->getEncryptPassword($params['password'], $params['salt']);
                    $params['avatar'] = '/assets/img/avatar.png'; //设置新管理员默认头像。
                    $params['admin_type'] = 'admin';
                    $params['miniapp_user_id'] = 0;
                    $params['parent_admin_id'] = $this->normalizeParentAdminId((int)($params['parent_admin_id'] ?? 0));
                    $params['invite_code'] = $this->generateAdminInviteCode();
                    $result = $this->model->validate('Admin.add')->save($params);
                    if ($result === false) {
                        exception($this->model->getError());
                    }
                    $group = $this->request->post("group/a");

                    //过滤不允许的组别,避免越权
                    $group = array_intersect($this->childrenGroupIds, $group);
                    if (!$group) {
                        exception(__('The parent group exceeds permission limit'));
                    }

                    $dataset = [];
                    foreach ($group as $value) {
                        $dataset[] = ['uid' => $this->model->id, 'group_id' => $value];
                    }
                    model('AuthGroupAccess')->saveAll($dataset);
                    Db::commit();
                } catch (\Exception $e) {
                    Db::rollback();
                    $this->error($e->getMessage());
                }
                $this->success();
            }
            $this->error(__('Parameter %s can not be empty', ''));
        }
        return $this->view->fetch();
    }

    /**
     * 编辑
     */
    public function edit($ids = null)
    {
        $row = $this->model->get(['id' => $ids]);
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        if (!in_array($row->id, $this->childrenAdminIds)) {
            $this->error(__('You have no permission'));
        }
        if ($this->request->isPost()) {
            $this->token();
            $params = $this->request->post("row/a");
            if ($params) {
                Db::startTrans();
                try {
                    if ($params['password']) {
                        if (!Validate::is($params['password'], '\S{6,30}')) {
                            exception(__("Please input correct password"));
                        }
                        $params['salt'] = Random::alnum();
                        $params['password'] = $this->auth->getEncryptPassword($params['password'], $params['salt']);
                    } else {
                        unset($params['password'], $params['salt']);
                    }
                    //这里需要针对username和email做唯一验证
                    $params['parent_admin_id'] = $this->normalizeParentAdminId((int)($params['parent_admin_id'] ?? 0), (int)$row->id, (int)($row['parent_admin_id'] ?? 0));
                    if (empty($row['invite_code'])) {
                        $params['invite_code'] = $this->generateAdminInviteCode();
                    }
                    unset($params['admin_type'], $params['miniapp_user_id']);
                    $adminValidate = \think\Loader::validate('Admin');
                    $adminValidate->rule([
                        'username' => 'require|regex:\w{3,30}|unique:admin,username,' . $row->id,
                        'email'    => 'require|email|unique:admin,email,' . $row->id,
                        'mobile'   => 'regex:1[3-9]\d{9}|unique:admin,mobile,' . $row->id,
                        'password' => 'regex:\S{32}',
                    ]);
                    $result = $row->validate('Admin.edit')->save($params);
                    if ($result === false) {
                        exception($row->getError());
                    }
                    // 先移除所有权限
                    model('AuthGroupAccess')->where('uid', $row->id)->delete();

                    $group = $this->request->post("group/a");

                    // 过滤不允许的组别,避免越权
                    $group = array_intersect($this->childrenGroupIds, $group);
                    if (!$group) {
                        exception(__('The parent group exceeds permission limit'));
                    }

                    $dataset = [];
                    foreach ($group as $value) {
                        $dataset[] = ['uid' => $row->id, 'group_id' => $value];
                    }
                    model('AuthGroupAccess')->saveAll($dataset);
                    Db::commit();
                } catch (\Exception $e) {
                    Db::rollback();
                    $this->error($e->getMessage());
                }
                $this->success();
            }
            $this->error(__('Parameter %s can not be empty', ''));
        }
        $this->view->assign('parentAdminList', $this->getParentAdminList((int)$row->id));
        $this->view->assign('canSelectParentAdmin', $this->auth->isSuperAdmin());
        $this->view->assign('defaultParentAdminId', (int)($row['parent_admin_id'] ?? 0));
        $this->view->assign('defaultParentAdminText', $this->getParentAdminDisplayName((int)($row['parent_admin_id'] ?? 0)));
        $row['invite_code'] = $this->ensureAdminInviteCode($row);
        $grouplist = $this->auth->getGroups($row['id']);
        $groupids = [];
        foreach ($grouplist as $k => $v) {
            $groupids[] = $v['id'];
        }
        $this->view->assign("row", $row);
        $this->view->assign("groupids", $groupids);
        return $this->view->fetch();
    }

    /**
     * 删除
     */
    public function del($ids = "")
    {
        if (!$this->request->isPost()) {
            $this->error(__("Invalid parameters"));
        }
        $ids = $ids ? $ids : $this->request->post("ids");
        if ($ids) {
            $ids = array_intersect($this->childrenAdminIds, array_filter(explode(',', $ids)));
            // 避免越权删除管理员
            $childrenGroupIds = $this->childrenGroupIds;
            $adminList = $this->model->where('id', 'in', $ids)->where('id', 'in', function ($query) use ($childrenGroupIds) {
                $query->name('auth_group_access')->where('group_id', 'in', $childrenGroupIds)->field('uid');
            })->select();
            if ($adminList) {
                $deleteIds = [];
                foreach ($adminList as $k => $v) {
                    $deleteIds[] = $v->id;
                }
                $deleteIds = array_values(array_diff($deleteIds, [$this->auth->id]));
                if ($deleteIds) {
                    Db::startTrans();
                    try {
                        $this->model->destroy($deleteIds);
                        model('AuthGroupAccess')->where('uid', 'in', $deleteIds)->delete();
                        Db::commit();
                    } catch (\Exception $e) {
                        Db::rollback();
                        $this->error($e->getMessage());
                    }
                    $this->success();
                }
                $this->error(__('No rows were deleted'));
            }
        }
        $this->error(__('You have no permission'));
    }

    /**
     * 批量更新
     * @internal
     */
    public function multi($ids = "")
    {
        // 管理员禁止批量操作
        $this->error();
    }

    /**
     * 下拉搜索
     */
    public function selectpage()
    {
        $this->dataLimit = 'auth';
        $this->dataLimitField = 'id';
        return parent::selectpage();
    }

    protected function getManageableAdminIds()
    {
        if ($this->auth->isSuperAdmin()) {
            return $this->auth->getChildrenAdminIds(true);
        }

        $roleAdminIds = array_map('intval', $this->auth->getChildrenAdminIds(false));
        $treeAdminIds = $this->getChildAdminIds((int)$this->auth->id, false);
        if (!$roleAdminIds || !$treeAdminIds) {
            return [];
        }

        return array_values(array_intersect($roleAdminIds, $treeAdminIds));
    }

    protected function getParentAdminList($excludeAdminId = 0)
    {
        $list = [0 => __('No parent admin')];
        if (!$this->auth->isSuperAdmin()) {
            $list[(int)$this->auth->id] = $this->auth->username;
            return $list;
        }

        $excludeIds = [];
        $excludeAdminId = (int)$excludeAdminId;
        if ($excludeAdminId > 0) {
            $excludeIds = $this->getChildAdminIds($excludeAdminId, true);
        }

        $query = $this->model
            ->where('status', '<>', 'hidden')
            ->field('id,username,nickname');
        if ($excludeIds) {
            $query->where('id', 'not in', $excludeIds);
        }

        $rows = $query->order('id', 'asc')->select();
        foreach ($rows as $row) {
            $list[(int)$row['id']] = $this->formatAdminDisplayName($row);
        }

        return $list;
    }

    protected function normalizeParentAdminId($parentAdminId, $rowId = 0, $currentParentAdminId = null)
    {
        if (!$this->auth->isSuperAdmin()) {
            return $rowId > 0 ? (int)$currentParentAdminId : (int)$this->auth->id;
        }

        $parentAdminId = (int)$parentAdminId;
        $rowId = (int)$rowId;
        if ($parentAdminId <= 0) {
            return 0;
        }
        if ($rowId > 0 && $parentAdminId === $rowId) {
            exception(__('Parent admin is invalid'));
        }
        if ($rowId > 0 && in_array($parentAdminId, $this->getChildAdminIds($rowId, true), true)) {
            exception(__('Parent admin is invalid'));
        }

        $parent = $this->model->where('id', $parentAdminId)->where('status', '<>', 'hidden')->find();
        if (!$parent) {
            exception(__('Parent admin is invalid'));
        }

        return $parentAdminId;
    }

    protected function getParentAdminMap($parentAdminIds)
    {
        $parentAdminIds = array_values(array_unique(array_filter(array_map('intval', (array)$parentAdminIds))));
        if (!$parentAdminIds) {
            return [];
        }

        $rows = $this->model
            ->where('id', 'in', $parentAdminIds)
            ->field('id,username,nickname')
            ->select();

        $map = [];
        foreach ($rows as $row) {
            $map[(int)$row['id']] = $this->formatAdminDisplayName($row);
        }

        return $map;
    }

    protected function getParentAdminDisplayName($parentAdminId)
    {
        $parentAdminId = (int)$parentAdminId;
        if ($parentAdminId <= 0) {
            return __('No parent admin');
        }

        $map = $this->getParentAdminMap([$parentAdminId]);
        return $map[$parentAdminId] ?? __('No parent admin');
    }

    protected function formatAdminDisplayName($row)
    {
        return (string)($row['nickname'] ?: $row['username'] ?: ('ID:' . $row['id']));
    }

    protected function ensureAdminInviteCode($row)
    {
        $inviteCode = trim((string)($row['invite_code'] ?? ''));
        if ($inviteCode !== '') {
            return $inviteCode;
        }

        $inviteCode = $this->generateAdminInviteCode();
        $this->model->where('id', (int)$row['id'])->update([
            'invite_code' => $inviteCode,
            'updatetime'  => time(),
        ]);

        return $inviteCode;
    }

    protected function generateAdminInviteCode()
    {
        for ($i = 0; $i < 20; $i++) {
            $code = 'A' . strtoupper(substr(md5($this->auth->id . '_' . microtime(true) . '_' . Random::alnum(8)), 0, 7));
            $adminExists = $this->model->where('invite_code', $code)->find();
            $userExists = Db::name('miniapp_user')->where('invite_code', $code)->find();
            if (!$adminExists && !$userExists) {
                return $code;
            }
        }

        return 'A' . strtoupper(substr(md5(uniqid('', true)), 0, 11));
    }
}
