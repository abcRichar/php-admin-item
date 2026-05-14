<?php

namespace app\api\controller\miniapp;

use think\Db;

class RotOrder extends MiniappBase
{
  protected function parseSequence($value, $type = 'raw')
  {
    $value = trim((string)$value);
    if ($value === '') {
      return [];
    }

    $items = array_values(array_filter(array_map('trim', explode('/', $value)), function ($item) {
      return $item !== '';
    }));

    if ($type === 'int') {
      return array_map('intval', $items);
    }

    if ($type === 'float') {
      return array_map('floatval', $items);
    }

    return $items;
  }

  protected function getSequenceValueByIndex($value, $index, $type = 'raw')
  {
    $items = $this->parseSequence($value, $type);
    if (!$items) {
      return null;
    }

    if (count($items) === 1) {
      return $items[0];
    }

    return $items[$index] ?? end($items);
  }

  protected function removeSequenceValueByIndex($value, $index, $preserveSingle = false)
  {
    $items = $this->parseSequence($value, 'raw');
    if (!$items || !isset($items[$index])) {
      return trim((string)$value);
    }

    if ($preserveSingle && count($items) === 1) {
      return trim((string)$value);
    }

    unset($items[$index]);
    return implode('/', array_values($items));
  }

  protected function resolveCommission($amount, $defaultRate, $profile)
  {
    $isUserSpecialRule = isset($profile['from_rule']) && $profile['from_rule'] === 'user';
    $fixedCommission = isset($profile['fixed_commission']) ? (float)$profile['fixed_commission'] : 0;
    if ($isUserSpecialRule && $fixedCommission > 0) {
      return round($fixedCommission, 2);
    }

    $commissionRate = isset($profile['commission_rate']) ? (float)$profile['commission_rate'] : 0;
    if ($isUserSpecialRule && $commissionRate > 0) {
      return round($amount * $commissionRate / 100, 2);
    }

    return round($amount * (float)$defaultRate, 2);
  }

  protected function getMiniappConfigValue($name, $language = null, $fallback = '')
  {
    $query = Db::name('miniapp_config')->where('name', $name);
    if ($language !== null) {
      $value = $query->where('language', $language)->value('value');
      if ($value !== null && $value !== '') {
        return $value;
      }
    }

    $value = Db::name('miniapp_config')->where('name', $name)->order('id asc')->value('value');
    if ($value === null || $value === '') {
      return $fallback;
    }

    return $value;
  }

  protected function resolveRuleIndex($dispatchOrderValue, $todayDan)
  {
    $orders = $this->parseSequence($dispatchOrderValue, 'int');
    if (!$orders) {
      return null;
    }

    foreach ($orders as $index => $orderNo) {
      if ($orderNo === 0 || $orderNo === (int)$todayDan) {
        return [
          'matched_index' => $index,
          'dispatch_order' => $orderNo,
          'orders' => $orders,
        ];
      }
    }

    return null;
  }

  protected function buildProfileByRule($dispatchOrderValue, $templateName, $commissionRateValue, $fixedCommissionValue, $dispatchAmountValue, $todayDan)
  {
    $rule = $this->resolveRuleIndex($dispatchOrderValue, $todayDan);
    if (!$rule) {
      return null;
    }

    $index = (int)$rule['matched_index'];
    return [
      'matched_index' => $index,
      'from_rule' => 'custom',
      'template_name' => (string)$templateName,
      'dispatch_order' => (int)$rule['dispatch_order'],
      'commission_rate' => $this->getSequenceValueByIndex($commissionRateValue, $index, 'float'),
      'fixed_commission' => $this->getSequenceValueByIndex($fixedCommissionValue, $index, 'float'),
      'dispatch_amount' => $this->getSequenceValueByIndex($dispatchAmountValue, $index, 'float'),
    ];
  }

  protected function mergeDispatchProfile($userProfile, $defaultProfile)
  {
    if (!$userProfile && !$defaultProfile) {
      return null;
    }

    $profile = [
      'matched_index' => $userProfile['matched_index'] ?? ($defaultProfile['matched_index'] ?? null),
      'dispatch_order' => $userProfile['dispatch_order'] ?? ($defaultProfile['dispatch_order'] ?? null),
      'from_rule' => $userProfile ? 'user' : ($defaultProfile ? 'default' : ''),
      'template_name' => '',
      'commission_rate' => null,
      'fixed_commission' => null,
      'dispatch_amount' => null,
    ];

    foreach (['template_name', 'commission_rate', 'fixed_commission', 'dispatch_amount'] as $field) {
      $userValue = $userProfile[$field] ?? null;
      if ($field === 'template_name') {
        $profile[$field] = $userValue !== null && $userValue !== '' ? $userValue : (string)($defaultProfile[$field] ?? '');
        continue;
      }
      $profile[$field] = $userValue !== null ? $userValue : ($defaultProfile[$field] ?? null);
    }

    return $profile;
  }

  protected function resolveDispatchProfile($user, $todayDan, $language)
  {
    $defaultProfile = $this->buildProfileByRule(
      (string)$this->getMiniappConfigValue('dispatch_order', $language, ''),
      (string)$this->getMiniappConfigValue('template_name', $language, ''),
      (string)$this->getMiniappConfigValue('commission_rate', $language, ''),
      (string)$this->getMiniappConfigValue('fixed_commission', $language, ''),
      (string)$this->getMiniappConfigValue('dispatch_amount', $language, ''),
      $todayDan
    );

    $userProfile = $this->buildProfileByRule(
      (string)($user['dispatch_order'] ?? ''),
      (string)($user['template_name'] ?? ''),
      (string)($user['commission_rate'] ?? ''),
      (string)($user['fixed_commission'] ?? ''),
      (string)($user['dispatch_amount'] ?? ''),
      $todayDan
    );

    return $this->mergeDispatchProfile($userProfile, $defaultProfile);
  }

  protected function buildDispatchOrderPlan($user, $goods, $todayDan, $language)
  {
    $goodsPrice = round((float)$goods['price'], 2);
    $balance = round((float)$user['balance'], 2);
    $maxGoodsCount = $goodsPrice > 0 ? (int)floor($balance / $goodsPrice) : 0;
    $goodsCount = $maxGoodsCount > 0 ? $maxGoodsCount : 1;
    $amount = round($goodsPrice * $goodsCount, 2);

    $profile = $this->resolveDispatchProfile($user, $todayDan, $language);
    $hasMatchedDispatchRule = $profile && isset($profile['dispatch_order']) && $profile['dispatch_order'] !== null;
    if ($hasMatchedDispatchRule && isset($profile['dispatch_amount']) && (float)$profile['dispatch_amount'] > 0) {
      $configAmount = round((float)$profile['dispatch_amount'], 2);
      $configGoodsCount = $goodsPrice > 0 ? (int)floor($configAmount / $goodsPrice) : 0;
      if ($configGoodsCount > 0) {
        $goodsCount = $configGoodsCount;
        $amount = round($goodsPrice * $goodsCount, 2);
      }
    }

    $defaultRate = (float)$this->getMiniappConfigValue('level_bili', $language, '0.006');
    if ($defaultRate <= 0) {
      $defaultRate = 0.006;
    }

    $lackAmount = $amount > $balance ? round($amount - $balance, 2) : 0.00;
    $maxOrderCount = $amount > 0 ? (int)floor($balance / $amount) : 0;

    return [
      'profile' => $profile,
      'has_matched_dispatch_rule' => $hasMatchedDispatchRule ? 1 : 0,
      'goods_count' => $goodsCount,
      'goods_price' => $goodsPrice,
      'amount' => $amount,
      'commission' => $this->resolveCommission($amount, $defaultRate, (array)$profile),
      'lack_amount' => $lackAmount,
      'can_submit' => $lackAmount <= 0,
      'max_order_count' => $maxOrderCount,
      'max_goods_count' => $maxGoodsCount,
      'default_rate' => $defaultRate,
    ];
  }

  protected function formatUndoneOrder($undoneOrder)
  {
    if (!$undoneOrder) {
      return new \stdClass();
    }

    $now = time();
    return [
      'oid'                    => (int)$undoneOrder['id'],
      'id'                     => (string)$undoneOrder['order_no'],
      'uid'                    => (int)$undoneOrder['user_id'],
      'level_id'               => (int)($undoneOrder['level_id'] ?? 0),
      'parent_uid'             => (int)($undoneOrder['parent_uid'] ?? 0),
      'num'                    => number_format((float)($undoneOrder['num'] ?? $undoneOrder['amount'] ?? 0), 2, '.', ''),
      'user_balance'           => number_format((float)($undoneOrder['user_balance'] ?? 0), 2, '.', ''),
      'user_freeze_balance'    => number_format((float)($undoneOrder['user_freeze_balance'] ?? 0), 2, '.', ''),
      'addtime'                => (int)($undoneOrder['addtime'] ?? 0),
      'term_time'              => $undoneOrder['term_time'] ?? null,
      'endtime'                => (int)($undoneOrder['endtime'] ?? 0),
      'status'                 => (int)($undoneOrder['status'] ?? 0),
      'is_pay'                 => (int)($undoneOrder['is_pay'] ?? 0),
      'pay_time'               => (int)($undoneOrder['pay_time'] ?? 0),
      'commission'             => number_format((float)($undoneOrder['commission'] ?? 0), 2, '.', ''),
      'parent_commission'      => number_format((float)($undoneOrder['parent_commission'] ?? 0), 2, '.', ''),
      'c_status'               => (int)($undoneOrder['c_status'] ?? 0),
      'add_id'                 => (int)($undoneOrder['add_id'] ?? 1),
      'goods_id'               => (int)($undoneOrder['goods_id'] ?? 0),
      'goods_count'            => (int)($undoneOrder['goods_count'] ?? 1),
      'group_id'               => (int)($undoneOrder['group_id'] ?? 0),
      'group_rule_num'         => (int)($undoneOrder['group_rule_num'] ?? 0),
      'group_is_active'        => (int)($undoneOrder['group_is_active'] ?? 1),
      'today_dan'              => (int)($undoneOrder['today_dan'] ?? 0),
      'qkon'                   => (int)($undoneOrder['qkon'] ?? 1),
      'group_completedornot'   => (int)($undoneOrder['group_completedornot'] ?? 1),
      'rands'                  => $undoneOrder['rands'] ?? null,
      'group_count'            => $undoneOrder['group_count'] ?? null,
      'duorw'                  => (int)($undoneOrder['duorw'] ?? 0),
      'rwdans'                 => $undoneOrder['rwdans'] ?? null,
      'zhuass'                 => (int)($undoneOrder['zhuass'] ?? 0),
      'goods_name'             => (string)($undoneOrder['goods_name'] ?? ''),
      'shop_name'              => (string)($undoneOrder['shop_name'] ?? $undoneOrder['goods_name'] ?? ''),
      'goods_price'            => number_format((float)($undoneOrder['goods_price'] ?? 0), 2, '.', ''),
      'goods_pic'              => (string)($undoneOrder['goods_pic'] ?? $undoneOrder['goods_image'] ?? ''),
      'time_limit'             => (int)$undoneOrder['endtime'] > 0
        ? (int)$undoneOrder['endtime'] - $now
        : 0,
    ];
  }

  protected function buildOrderUndonePreview($user, $goods, $dispatchPlan, $todayDan)
  {
    if (!$goods || !$dispatchPlan) {
      return null;
    }

    Db::startTrans();
    try {
      $undoneOrder = Db::name('miniapp_order')
        ->where('user_id', (int)$user['id'])
        ->where('status', 'in', [0, 1])
        ->lock(true)
        ->order('id desc')
        ->find();
      if ($undoneOrder) {
        Db::commit();
        return $undoneOrder;
      }

      $now = time();
      $orderNo = 'UB' . date('ymdHis', $now) . mt_rand(1000, 9999);
      $orderId = Db::name('miniapp_order')->insertGetId([
        'user_id' => (int)$user['id'],
        'uid' => (int)$user['id'],
        'level_id' => (int)($user['level'] ?? 0),
        'parent_uid' => (int)($user['parent_id'] ?? 0),
        'order_no' => $orderNo,
        'goods_id' => (int)($goods['id'] ?? 0),
        'goods_count' => (int)($dispatchPlan['goods_count'] ?? 1),
        'goods_name' => (string)($goods['title'] ?? ''),
        'shop_name' => (string)($goods['title'] ?? ''),
        'goods_price' => (float)($dispatchPlan['goods_price'] ?? $goods['price'] ?? 0),
        'goods_pic' => (string)($goods['image'] ?? ''),
        'goods_image' => (string)($goods['image'] ?? ''),
        'today_dan' => (int)$todayDan,
        'qkon' => 1,
        'group_id' => 0,
        'group_rule_num' => 0,
        'group_is_active' => 0,
        'group_completedornot' => 1,
        'rands' => null,
        'group_count' => null,
        'duorw' => 0,
        'rwdans' => null,
        'zhuass' => 0,
        'time_limit' => 0,
        'amount' => (float)$dispatchPlan['amount'],
        'num' => (float)$dispatchPlan['amount'],
        'user_balance' => (float)$user['balance'],
        'user_freeze_balance' => (float)($user['freeze_balance'] ?? 0),
        'addtime' => $now,
        'term_time' => null,
        'endtime' => 0,
        'is_pay' => 0,
        'commission' => (float)$dispatchPlan['commission'],
        'parent_commission' => $this->calculateParentCommission((float)$dispatchPlan['commission']),
        'c_status' => 0,
        'add_id' => 1,
        'status' => 0,
        'source' => 'order_info',
        'language' => $this->getLanguageValue(),
        'remark' => '',
        'pay_time' => 0,
        'complete_time' => 0,
        'create_time' => $now,
        'update_time' => $now,
      ]);

      Db::name('miniapp_order_action_log')->insert([
        'user_id' => (int)$user['id'],
        'order_id' => (int)$orderId,
        'order_no' => $orderNo,
        'action' => 'order_info',
        'amount' => (float)$dispatchPlan['amount'],
        'status' => 1,
        'create_time' => $now,
      ]);

      $undoneOrder = Db::name('miniapp_order')->where('id', (int)$orderId)->find();
      Db::commit();
      return $undoneOrder ?: null;
    } catch (\Throwable $e) {
      Db::rollback();
      return null;
    }
  }

  protected function assertTaskUpdateEnabled($user)
  {
    if ((int)($user['task_update_status'] ?? 1) !== 1) {
      $this->apiError(__('miniapp.task_update_disabled'), null, 400);
    }
  }

  protected function closeTaskUpdateStatus($userId)
  {
    Db::name('miniapp_user')->where('id', (int)$userId)->update([
      'task_update_status' => 0,
      'update_time'        => time(),
    ]);
  }
  /**
   * 抢单页数据 - 对齐线上字段
   * 线上返回: {lock_deal, day_deal, completed_count, order_num, level_bili,
   *   order_incomplete_num, uinfo{...}, price, desc_info, ..., order_undone{...}}
   */
  public function orderInfo()
  {
    $this->execute(function () {
      $user = $this->getMiniappUser();
      $language = $this->getLanguageValue();

      // 统计数据
      $today_start = $this->getBusinessTodayStartTime();
      $completedCount = (int)Db::name('miniapp_order')
        ->where('user_id', (int)$user['id'])->where('status', 2)
        ->where('complete_time', '>=', $today_start)->count();
      $todayCompleted = (int)Db::name('miniapp_order')
        ->where('user_id', (int)$user['id'])->where('status', 2)
        ->where('complete_time', '>=', $today_start)->count();
      $incompleteCount = (int)Db::name('miniapp_order')
        ->where('user_id', (int)$user['id'])->where('status', 'in', [0, 1])->count();

      // 今日佣金
      $commissionToday = (float)Db::name('miniapp_order')
        ->where('user_id', (int)$user['id'])->where('status', 2)
        ->where('complete_time', '>=', $today_start)->sum('commission');
      // 全部佣金
      $commissionAll = (float)Db::name('miniapp_order')
        ->where('user_id', (int)$user['id'])->where('status', 2)->sum('commission');
      // 下级佣金
      $commissionSubordinate = (float)Db::name('miniapp_finance_log')
        ->where('user_id', (int)$user['id'])->where('type', 4)->sum('amount');

      // 冻结金额
      $lockDeal = (float)Db::name('miniapp_order')
        ->where('user_id', (int)$user['id'])->where('status', 1)->sum('num');

      // 今日收益
      $dayDeal = $commissionAll;

      // 配置
      $getConf = function ($name) use ($language) {
        $val = Db::name('miniapp_config')->where('name', $name)->where('language', $language)->value('value');
        if ($val === null) {
          $val = Db::name('miniapp_config')->where('name', $name)->value('value');
        }
        return $val;
      };
      $levelBili = (float)($getConf('level_bili') ?: 0.006);
      $orderNum  = (int)($getConf('order_num') ?: 60);
      $descInfo  = (string)($getConf('desc_info') ?: '');
      $dealZhujiTime = (string)($getConf('deal_zhuji_time') ?: '1');
      $dealShopTime  = (string)($getConf('deal_shop_time') ?: '2');
      $currentGoods = Db::name('miniapp_goods')->where('status', 1)->where('language', $language)->order('sort desc,id asc')->find();
      if (!$currentGoods) {
        $currentGoods = Db::name('miniapp_goods')->where('status', 1)->where('language', self::LANGUAGE_CN)->order('sort desc,id asc')->find();
      }
      $nextTodayDan = $todayCompleted + $incompleteCount + 1;
      $dispatchPlan = $currentGoods ? $this->buildDispatchOrderPlan($user, $currentGoods, $nextTodayDan, $language) : null;

      // uinfo
      $uinfo = [
        'id'             => (int)$user['id'],
        'tel'            => (string)$user['tel'],
        'username'       => (string)($user['username'] ?: $user['nickname']),
        'invite_code'    => (string)$user['invite_code'],
        'balance'        => number_format((float)$user['balance'], 2, '.', ''),
        'freeze_balance' => number_format((float)($user['freeze_balance'] ?? 0), 2, '.', ''),
        'group_id'       => (int)($user['group_id'] ?? 0),
        'level'          => (int)($user['level'] ?? 0),
        'deal_num'       => (int)($user['deal_num'] ?? 0),
      ];

      // 未完成订单
      $undoneOrder = Db::name('miniapp_order')
        ->where('user_id', (int)$user['id'])
        ->where('status', 'in', [0, 1])
        ->order('id desc')
        ->find();

      if ($undoneOrder && (int)$undoneOrder['status'] === 0) {
        $this->assertTaskUpdateEnabled($user);
      }

      if (!$undoneOrder) {
        $this->assertTaskUpdateEnabled($user);
        $undoneOrder = $this->buildOrderUndonePreview($user, $currentGoods, $dispatchPlan, $nextTodayDan);
        if ($undoneOrder) {
          $incompleteCount++;
        }
      }

      $orderUndone = $this->formatUndoneOrder($undoneOrder);

      $this->logRequest((int)$user['id']);
      $this->apiSuccess(__('miniapp.success'), [
        'lock_deal'              => number_format($lockDeal, 2, '.', ''),
        'day_deal'               => (float)$dayDeal,
        'completed_count'        => $completedCount,
        'order_num'              => $orderNum,
        'level_bili'             => $levelBili,
        'order_incomplete_num'   => $incompleteCount,
        'uinfo'                  => $uinfo,
        'price'                  => number_format((float)$user['balance'], 2, '.', ''),
        'desc_info'              => $descInfo,
        'deal_zhuji_time'        => $dealZhujiTime,
        'deal_shop_time'         => $dealShopTime,
        'commission_today'       => (float)$commissionToday,
        'commission_all'         => (float)$commissionAll,
        'commission_subordinate' => (float)$commissionSubordinate,
        'order_undone'           => $orderUndone,
      ]);
    });
  }

  /**
   * 提交(抢)订单 - 对齐线上逻辑
   * 有未完成订单则拒绝
   */
  public function submit_order()
  {
    $this->execute(function () {
      $user = $this->getMiniappUser();

      // 检查未完成订单
      $undone = Db::name('miniapp_order')
        ->where('user_id', (int)$user['id'])
        ->where('status', 'in', [0, 1])
        ->order('id desc')
        ->find();
      if ($undone) {
        if ((int)$undone['status'] === 1) {
          $this->apiError(__('miniapp.has_undone_order'), null, 400);
        }
        $this->assertTaskUpdateEnabled($user);

        $requiredAmount = round((float)($undone['num'] ?? $undone['amount'] ?? 0), 2);
        $balance = round((float)$user['balance'], 2);
        $lackAmount = $requiredAmount > $balance ? round($requiredAmount - $balance, 2) : 0.00;
        if ($lackAmount > 0) {
          $this->apiError(__('miniapp.balance_not_enough'), [
            'balance' => (string)$user['balance'],
            'required_amount' => (string)$requiredAmount,
            'lack_amount' => (string)$lackAmount,
            'max_order_count' => $requiredAmount > 0 ? (int)floor($balance / $requiredAmount) : 0,
            'goods_price' => (string)($undone['goods_price'] ?? 0),
            'goods_count' => (int)($undone['goods_count'] ?? 1),
          ], 400);
        }

        $now = time();
        Db::startTrans();
        try {
          Db::name('miniapp_order')->where('id', (int)$undone['id'])->update([
            'status' => 1,
            'is_pay' => 1,
            'pay_time' => $now,
            'c_status' => 1,
            'endtime' => $now + 3600,
            'user_balance' => (float)$user['balance'],
            'user_freeze_balance' => (float)($user['freeze_balance'] ?? 0),
            'update_time' => $now,
          ]);
          Db::name('miniapp_order_action_log')->insert([
            'user_id' => (int)$user['id'],
            'order_id' => (int)$undone['id'],
            'order_no' => (string)$undone['order_no'],
            'action' => 'submit_order',
            'amount' => $requiredAmount,
            'status' => 1,
            'create_time' => $now,
          ]);
          Db::name('miniapp_user')->where('id', (int)$user['id'])->update([
            'task_update_status' => 0,
            'update_time' => $now,
          ]);
          Db::commit();
        } catch (\Throwable $e) {
          Db::rollback();
          $this->apiError(__('miniapp.operation_failed'), null, 500);
        }

        $this->logRequest((int)$user['id']);
        $this->apiSuccess(__('miniapp.success'), [
          'order_no' => (string)$undone['order_no'],
          'amount' => $requiredAmount,
        ]);
      }

      $language = $this->getLanguageValue();
      $goods = Db::name('miniapp_goods')->where('status', 1)->where('language', $language)->order('sort desc,id asc')->find();
      if (!$goods) {
        $goods = Db::name('miniapp_goods')->where('status', 1)->where('language', self::LANGUAGE_CN)->order('sort desc,id asc')->find();
      }
      if (!$goods) {
        $this->apiError(__('miniapp.goods_not_found'), null, 404);
      }
      $this->assertTaskUpdateEnabled($user);

      $now = time();
      $orderNo   = 'UB' . date('ymdHis') . mt_rand(1000, 9999);
      $todayDan  = (int)Db::name('miniapp_order')
        ->where('user_id', (int)$user['id'])
        ->where('addtime', '>=', strtotime(date('Y-m-d')))->count() + 1;
      $dispatchPlan = $this->buildDispatchOrderPlan($user, $goods, $todayDan, $language);
      if (!$dispatchPlan['can_submit']) {
        $this->apiError(__('miniapp.balance_not_enough'), [
          'balance' => (string)$user['balance'],
          'required_amount' => (string)$dispatchPlan['amount'],
          'lack_amount' => (string)$dispatchPlan['lack_amount'],
          'max_order_count' => (int)$dispatchPlan['max_order_count'],
          'goods_price' => (string)$dispatchPlan['goods_price'],
          'goods_count' => (int)$dispatchPlan['goods_count'],
        ], 400);
      }

      $userSetting = $dispatchPlan['profile'];
      $goodsCount = (int)$dispatchPlan['goods_count'];
      $goodsPrice = (float)$dispatchPlan['goods_price'];
      $amount = (float)$dispatchPlan['amount'];
      $commission = (float)$dispatchPlan['commission'];

      Db::startTrans();
      try {
        Db::name('miniapp_order')->insert([
          'user_id' => (int)$user['id'],
          'uid' => (int)$user['id'],
          'level_id' => (int)($user['level'] ?? 0),
          'parent_uid' => (int)$user['parent_id'],
          'order_no' => $orderNo,
          'goods_id' => (int)$goods['id'],
          'goods_count' => $goodsCount,
          'goods_name' => (string)$goods['title'],
          'shop_name' => (string)$goods['title'],
          'goods_price' => $goodsPrice,
          'goods_pic' => (string)$goods['image'],
          'goods_image' => (string)$goods['image'],
          'amount' => $amount,
          'num' => $amount,
          'user_balance' => (float)$user['balance'],
          'user_freeze_balance' => (float)($user['freeze_balance'] ?? 0),
          'addtime' => $now,
          'endtime' => $now + 3600,
          'status' => 1,
          'is_pay' => 1,
          'pay_time' => $now,
          'commission' => $commission,
          'parent_commission' => $this->calculateParentCommission($commission),
          'c_status' => 1,
          'add_id' => 1,
          'today_dan' => $todayDan,
          'qkon' => 1,
          'group_completedornot' => 1,
          'source' => $userSetting && !empty($userSetting['template_name']) ? (string)$userSetting['template_name'] : 'submit_order',
          'language' => $language,
          'create_time' => $now,
          'update_time' => $now,
        ]);
        Db::name('miniapp_order_action_log')->insert([
          'user_id' => (int)$user['id'],
          'order_id' => 0,
          'order_no' => $orderNo,
          'action' => 'submit_order',
          'amount' => $amount,
          'status' => 1,
          'create_time' => $now,
        ]);
        if ($userSetting && ($userSetting['from_rule'] ?? '') === 'user' && (int)($userSetting['dispatch_order'] ?? -1) === 0) {
          $matchedIndex = (int)($userSetting['matched_index'] ?? 0);
          Db::name('miniapp_user')->where('id', (int)$user['id'])->update([
            'dispatch_order' => $this->removeSequenceValueByIndex($user['dispatch_order'] ?? '', $matchedIndex),
            'commission_rate' => $this->removeSequenceValueByIndex($user['commission_rate'] ?? '', $matchedIndex, true),
            'fixed_commission' => $this->removeSequenceValueByIndex($user['fixed_commission'] ?? '', $matchedIndex, true),
            'dispatch_amount' => $this->removeSequenceValueByIndex($user['dispatch_amount'] ?? '', $matchedIndex, true),
            'update_time' => $now,
          ]);
        }
        Db::name('miniapp_user')->where('id', (int)$user['id'])->update([
          'task_update_status' => 0,
          'update_time' => $now,
        ]);
        Db::commit();
      } catch (\Throwable $e) {
        Db::rollback();
        $this->apiError(__('miniapp.operation_failed'), null, 500);
      }

      $this->logRequest((int)$user['id']);
      $this->apiSuccess(__('miniapp.success'), ['order_no' => $orderNo, 'amount' => $amount]);
    });
  }
}
