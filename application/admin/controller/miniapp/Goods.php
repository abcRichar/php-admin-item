<?php

namespace app\admin\controller\miniapp;

use app\common\controller\Backend;

/**
 * 商品管理
 *
 * @icon fa fa-shopping-bag
 */
class Goods extends Backend
{
    protected $model = null;
    protected $modelValidate = true;
    protected $searchFields = 'id,title,sub_title,language';

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\MiniappGoods;
        $this->assignconfig('statusList', $this->model->getStatusList());
        $this->assignconfig('languageList', $this->model->getLanguageList());
        $this->view->assign('statusList', $this->model->getStatusList());
        $this->view->assign('languageList', $this->model->getLanguageList());
    }
}
