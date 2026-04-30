<?php

namespace app\api\controller\miniapp;

use think\Db;

class Index extends MiniappBase
{
  /**
   * 首页数据：余额 + 轮播 + 滚动列表
   * 线上字段: balance, banner[{id,image,title,url}], scroll_list[{addtime,name,today_income}]
   */
  public function homeNew()
  {
    $this->execute(function () {
      $user = $this->getMiniappUser();
      $language = $this->getLanguageValue();

      // banner
      $banner = Db::name('miniapp_home')
        ->where('status', 1)
        ->where('language', $language)
        ->order('sort desc,id desc')
        ->find();
      $bannerList = [];
      if ($banner && !empty($banner['banner_list'])) {
        $decoded = is_string($banner['banner_list']) ? json_decode($banner['banner_list'], true) : $banner['banner_list'];
        $bannerList = is_array($decoded) ? $decoded : [];
      }

      // scroll_list
      $scrollList = Db::name('miniapp_scroll_list')
        ->where('status', 1)
        ->field('addtime, name, today_income')
        ->order('id desc')
        ->limit(30)
        ->select();

      $this->logRequest((int)$user['id']);
      $this->apiSuccess(__('miniapp.success'), [
        'balance'     => (string)$user['balance'],
        'banner'      => $bannerList,
        'scroll_list' => $scrollList ?: [],
      ]);
    });
  }
}
