<?php

namespace app\admin\controller\miniapp;

use app\common\controller\Backend;
use think\Db;

/**
 * 派单模式管理
 *
 * @icon fa fa-list
 */
class DispatchMode extends Backend
{
    protected $model = null;
    protected $modelValidate = false;
    protected $searchFields = 'id,template_name';
    protected $noNeedRight = ['selectpage'];

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\MiniappDispatchMode;
        $this->assignconfig('statusList', $this->model->getStatusList());
        $this->view->assign('statusList', $this->model->getStatusList());
    }

    public function add()
    {
        if (!$this->request->isPost()) {
            return $this->view->fetch();
        }

        $params = $this->normalizeParams($this->request->post('row/a'));
        $params['creator_admin_id'] = $this->auth->isSuperAdmin() ? 0 : $this->getCurrentAdminId();
        Db::startTrans();
        try {
            $result = $this->model->allowField(true)->save($params);
            if ($result === false) {
                throw new \RuntimeException(__('No rows were inserted'));
            }
            Db::commit();
        } catch (\Throwable $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }
        $this->success();
    }

    public function edit($ids = null)
    {
        $row = $this->model->get($ids);
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        $this->assertCanManageDispatchMode($row);
        if (!$this->request->isPost()) {
            $this->view->assign('row', $row);
            return $this->view->fetch();
        }

        $params = $this->normalizeParams($this->request->post('row/a'));
        Db::startTrans();
        try {
            $result = $row->allowField(true)->save($params);
            if ($result === false) {
                throw new \RuntimeException(__('No rows were updated'));
            }
            Db::commit();
        } catch (\Throwable $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }
        $this->success();
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
            $this->applyOwnManageScope($query);
            $list = $query->order($sort, $order)->paginate($limit);

            $items = $list->items();
            $creatorAdminIds = [];
            foreach ($items as $row) {
                if (!empty($row['creator_admin_id'])) {
                    $creatorAdminIds[] = (int)$row['creator_admin_id'];
                }
            }
            $creatorMap = $this->getCreatorAdminNameMap($creatorAdminIds);
            foreach ($items as $row) {
                $creatorAdminId = (int)($row['creator_admin_id'] ?? 0);
                $row['creator_username'] = $creatorAdminId > 0 ? ($creatorMap[$creatorAdminId] ?? '--') : __('Super admin');
            }

            return json([
                'total' => $list->total(),
                'rows'  => $items,
            ]);
        }

        return $this->view->fetch();
    }

    public function del($ids = null)
    {
        if (!$this->request->isPost()) {
            $this->error(__("Invalid parameters"));
        }

        $ids = $ids ?: $this->request->post('ids');
        $ids = array_values(array_unique(array_filter(array_map('intval', explode(',', (string)$ids)))));
        if (!$ids) {
            $this->error(__('Parameter %s can not be empty', 'ids'));
        }

        $query = $this->model->where('id', 'in', $ids);
        $this->applyOwnManageScope($query);
        $list = $query->select();
        if (count($list) !== count($ids)) {
            $this->error(__('You have no permission'), '');
        }

        Db::startTrans();
        try {
            $count = 0;
            foreach ($list as $item) {
                $count += $item->delete();
            }
            if (!$count) {
                throw new \RuntimeException(__('No rows were deleted'));
            }
            Db::commit();
        } catch (\Throwable $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }

        $this->success();
    }

    protected function normalizeParams($params)
    {
        if (!$params) {
            $this->error(__('Parameter %s can not be empty', ''));
        }

        return [
            'template_name'    => trim((string)($params['template_name'] ?? '')),
            'dispatch_order'   => $this->normalizeSequenceValue($params['dispatch_order'] ?? '', 'int'),
            'commission_rate'  => $this->normalizeSequenceValue($params['commission_rate'] ?? '', 'number'),
            'fixed_commission' => $this->normalizeSequenceValue($params['fixed_commission'] ?? '', 'number'),
            'dispatch_amount'  => $this->normalizeSequenceValue($params['dispatch_amount'] ?? '', 'number'),
            'difference_amount' => $this->normalizeSequenceValue($params['difference_amount'] ?? '', 'number'),
            'status'           => isset($params['status']) ? (int)$params['status'] : 1,
            'sort'             => isset($params['sort']) ? (int)$params['sort'] : 0,
        ];
    }

    protected function applyOwnManageScope($query)
    {
        if ($this->auth && $this->auth->isSuperAdmin()) {
            return $query;
        }

        $adminId = $this->getCurrentAdminId();
        return $adminId > 0 ? $query->where('creator_admin_id', $adminId) : $query->where('1=0');
    }

    protected function assertCanManageDispatchMode($row)
    {
        if ($this->auth && $this->auth->isSuperAdmin()) {
            return;
        }

        $creatorAdminId = (int)($row['creator_admin_id'] ?? 0);
        if ($creatorAdminId <= 0) {
            $this->error(__('Super admin dispatch mode can not be modified'), '');
        }

        if ($creatorAdminId !== $this->getCurrentAdminId()) {
            $this->error(__('You have no permission'), '');
        }
    }

    protected function getCreatorAdminNameMap(array $adminIds)
    {
        $adminIds = array_values(array_unique(array_filter(array_map('intval', $adminIds))));
        if (!$adminIds) {
            return [];
        }

        $rows = Db::name('admin')
            ->where('id', 'in', $adminIds)
            ->field('id,username,nickname,mobile')
            ->select();

        $map = [];
        foreach ($rows as $row) {
            $name = trim((string)($row['username'] ?? ''));
            if ($name === '') {
                $name = trim((string)($row['nickname'] ?? ''));
            }
            if ($name === '') {
                $name = trim((string)($row['mobile'] ?? ''));
            }
            $map[(int)$row['id']] = $name !== '' ? $name : '--';
        }

        return $map;
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
}
