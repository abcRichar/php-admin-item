<?php

namespace app\admin\controller\miniapp;

use app\common\controller\Backend;

/**
 * 充值记录
 *
 * @icon fa fa-credit-card
 */
class RechargeRecord extends Backend
{
    protected $model = null;
    protected $searchFields = 'id,oid,related_order_no,remark,tel,username,nickname';

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\MiniappFinanceLog;
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
                ->where('record.type', UserSetting::FINANCE_TYPE_ADMIN_RECHARGE)
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
}
