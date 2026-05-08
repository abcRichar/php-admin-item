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
            'status'           => isset($params['status']) ? (int)$params['status'] : 1,
            'sort'             => isset($params['sort']) ? (int)$params['sort'] : 0,
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
}
