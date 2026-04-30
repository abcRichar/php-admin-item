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
            $list = $this->model
                ->alias('record')
                ->join('fa_miniapp_user user', 'user.id = record.user_id', 'LEFT')
                ->field('record.*,user.tel,user.username,user.nickname')
                ->where($where)
                ->order($sort, $order)
                ->paginate($limit);

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
}
