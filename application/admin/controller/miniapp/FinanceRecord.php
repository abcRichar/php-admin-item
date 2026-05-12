<?php

namespace app\admin\controller\miniapp;

use app\common\controller\Backend;
use think\Db;

/**
 * 账变记录
 *
 * @icon fa fa-money
 */
class FinanceRecord extends Backend
{
    protected $model = null;
    protected $searchFields = 'id,oid,related_order_no,remark,tel,username,nickname';

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\MiniappFinanceLog;
        $this->assignconfig('typeList', $this->model->getTypeList());
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
            if (!$this->auth->isSuperAdmin()) {
                $scopedUserIds = $this->getScopedMiniappUserIds(false);
                $agentUserId = $this->isMiniappAgentAdmin() ? $this->getMiniappAgentUserId() : 0;
                $query->where(function ($query) use ($scopedUserIds, $agentUserId) {
                    if ($scopedUserIds) {
                        $query->where('record.user_id', 'in', $scopedUserIds);
                    } else {
                        $query->where('1=0');
                    }
                    if ($agentUserId > 0) {
                        $query->whereOr(function ($query) use ($agentUserId) {
                            $query->where('record.user_id', $agentUserId)
                                ->where('record.type', 4);
                        });
                    }
                });
            }
            $list = $query->order($sort, $order)->paginate($limit);

            $sourceUserIds = [];
            foreach ($list as $row) {
                if (!empty($row['sid'])) {
                    $sourceUserIds[] = (int)$row['sid'];
                }
            }
            $sourceUserMap = $this->getMiniappUserDisplayNameMap($sourceUserIds);

            foreach ($list as $row) {
                $row['display_name'] = (string)($row['username'] ?: $row['nickname'] ?: $row['tel'] ?: ('UID:' . $row['user_id']));
                $row['source_display_name'] = $sourceUserMap[(int)($row['sid'] ?? 0)] ?? ((int)($row['sid'] ?? 0) > 0 ? ('UID:' . (int)$row['sid']) : '--');
            }

            return json([
                'total' => $list->total(),
                'rows'  => $list->items(),
            ]);
        }

        return $this->view->fetch();
    }

    protected function getMiniappUserDisplayNameMap(array $userIds)
    {
        $userIds = array_values(array_unique(array_filter(array_map('intval', $userIds))));
        if (!$userIds) {
            return [];
        }

        $rows = Db::name('miniapp_user')
            ->where('id', 'in', $userIds)
            ->field('id,tel,username,nickname')
            ->select();

        $map = [];
        foreach ($rows as $row) {
            $map[(int)$row['id']] = (string)($row['username'] ?: $row['nickname'] ?: $row['tel'] ?: ('UID:' . $row['id']));
        }

        return $map;
    }
}
