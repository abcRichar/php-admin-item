<?php

namespace app\admin\controller\miniapp;

use app\common\controller\Backend;

/**
 * 抢单记录
 *
 * @icon fa fa-list-alt
 */
class OrderActionRecord extends Backend
{
    protected $model = null;
    protected $searchFields = 'id,order_no,action,tel,username,nickname';
    protected $recordFields = ['id', 'user_id', 'order_id', 'order_no', 'action', 'amount', 'status', 'create_time'];
    protected $userFields = ['tel', 'username', 'nickname'];

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\MiniappOrderActionLog;
        $this->assignconfig('actionList', $this->model->getActionList());
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
            $where = $this->normalizeQueryFields($where);
            $createTimeRange = $this->extractIntegerTimeRange($where, 'record.create_time');
            $sort = $this->normalizeSortField($sort);
            $query = $this->model
                ->alias('record')
                ->join('fa_miniapp_user user', 'user.id = record.user_id', 'LEFT')
                ->field('record.*,user.tel,user.username,user.nickname')
                ->where($where);
            if (isset($createTimeRange['start'])) {
                $query->where('record.create_time', '>=', $createTimeRange['start']);
            }
            if (isset($createTimeRange['end'])) {
                $query->where('record.create_time', '<=', $createTimeRange['end']);
            }
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

    protected function normalizeQueryFields($where)
    {
        foreach ($where as &$condition) {
            if (!is_array($condition) || !isset($condition[0]) || !is_string($condition[0])) {
                continue;
            }
            $fields = explode('|', $condition[0]);
            foreach ($fields as &$field) {
                $field = $this->normalizeField($field);
            }
            unset($field);
            $condition[0] = implode('|', $fields);
        }
        unset($condition);

        return $where;
    }

    protected function normalizeSortField($sort)
    {
        $fields = explode(',', (string)$sort);
        foreach ($fields as &$field) {
            $field = $this->normalizeField($field);
        }
        unset($field);

        return implode(',', $fields);
    }

    protected function extractIntegerTimeRange(&$where, $field)
    {
        $range = [];
        foreach ($where as &$condition) {
            if (!is_array($condition) || count($condition) < 3 || ($condition[0] ?? '') !== $field) {
                continue;
            }

            $operator = strtoupper((string)$condition[1]);
            if (strpos($operator, 'TIME') === false) {
                continue;
            }

            $operator = trim(str_replace('TIME', '', $operator));
            $value = $condition[2];
            if ($operator === 'BETWEEN') {
                $values = is_array($value) ? array_values($value) : explode(',', (string)$value);
                if (isset($values[0]) && $values[0] !== '') {
                    $range['start'] = $this->normalizeTimestampValue($values[0]);
                }
                if (isset($values[1]) && $values[1] !== '') {
                    $range['end'] = $this->normalizeTimestampValue($values[1]);
                }
                $condition = null;
                continue;
            }
            if ($operator === '>=' || $operator === '>') {
                $range['start'] = $this->normalizeTimestampValue($value);
                $condition = null;
                continue;
            }
            if ($operator === '<=' || $operator === '<') {
                $range['end'] = $this->normalizeTimestampValue($value);
                $condition = null;
            }
        }
        unset($condition);

        $where = array_values(array_filter($where, function ($condition) {
            return $condition !== null;
        }));

        return $range;
    }

    protected function normalizeTimestampValue($value)
    {
        if (is_numeric($value)) {
            return (int)$value;
        }

        $timestamp = strtotime((string)$value);
        return $timestamp ?: 0;
    }

    protected function normalizeField($field)
    {
        $field = trim((string)$field);
        if ($field === '' || strpos($field, '.') !== false) {
            return $field;
        }
        if (in_array($field, $this->userFields, true)) {
            return 'user.' . $field;
        }
        if (in_array($field, $this->recordFields, true)) {
            return 'record.' . $field;
        }

        return $field;
    }
}
