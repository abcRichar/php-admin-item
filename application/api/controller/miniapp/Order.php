<?php

namespace app\api\controller\miniapp;

use think\Db;

class Order extends MiniappBase
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

  protected function resolveCommission($amount, $defaultRate, $profile)
  {
    $fixedCommission = isset($profile['fixed_commission']) ? (float)$profile['fixed_commission'] : 0;
    if ($fixedCommission > 0) {
      return round($fixedCommission, 2);
    }

    $commissionRate = isset($profile['commission_rate']) ? (float)$profile['commission_rate'] : 0;
    if ($commissionRate > 0) {
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

    return [
      'goods_count' => $goodsCount,
      'goods_price' => $goodsPrice,
      'amount' => $amount,
      'commission' => $this->resolveCommission($amount, $defaultRate, (array)$profile),
    ];
  }

  protected function buildPreviewOrderData($user, $goods, $dispatchPlan, $todayDan, $language)
  {
    if (!$goods || !$dispatchPlan) {
      return null;
    }

    $previewOrderNo = 'UBP' . (int)$user['id'] . '_' . (int)($goods['id'] ?? 0) . '_' . (int)$todayDan . '_' . (int)$language;
    return [
      'oid' => $previewOrderNo,
      'commission' => number_format((float)$dispatchPlan['commission'], 2, '.', ''),
      'addtime' => time(),
      'endtime' => '',
      'status' => 2,
      'num' => number_format((float)$dispatchPlan['amount'], 2, '.', ''),
      'goods_count' => (int)$dispatchPlan['goods_count'],
      'add_id' => 1,
      'goods_name' => (string)($goods['title'] ?? ''),
      'goods_price' => number_format((float)$dispatchPlan['goods_price'], 2, '.', ''),
      'shop_name' => (string)($goods['title'] ?? ''),
      'goods_pic' => (string)($goods['image'] ?? ''),
      'group_rule_num' => 0,
      'group_id' => 0,
      'rands' => null,
      'group_count' => null,
      'duorw' => 0,
      'is_pay' => 0,
      'group_is_active' => 1,
      'yuji' => round((float)$dispatchPlan['amount'] + (float)$dispatchPlan['commission'], 2),
    ];
  }

  protected function resolvePreviewOrderInfo($user, $orderNo)
  {
    if (!preg_match('/^UBP(\d+)_(\d+)_(\d+)_(\d+)$/', (string)$orderNo, $matches)) {
      return null;
    }

    $previewUserId = (int)$matches[1];
    $goodsId = (int)$matches[2];
    $todayDan = (int)$matches[3];
    $language = (int)$matches[4];
    if ($previewUserId !== (int)$user['id']) {
      return null;
    }

    $goods = Db::name('miniapp_goods')
      ->where('id', $goodsId)
      ->where('status', 1)
      ->find();
    if (!$goods) {
      return null;
    }

    $dispatchPlan = $this->buildDispatchOrderPlan($user, $goods, $todayDan, $language);
    if (!$dispatchPlan) {
      return null;
    }

    $userInfo = Db::name('miniapp_user_info')->where('user_id', (int)$user['id'])->find();
    $completedCount = (int)Db::name('miniapp_order')
      ->where('user_id', (int)$user['id'])
      ->where('status', 2)
      ->count();

    $orderData = $this->buildPreviewOrderData($user, $goods, $dispatchPlan, $todayDan, $language);
    if (!$orderData) {
      return null;
    }

    $orderData['name'] = $userInfo ? (string)$userInfo['realname'] : null;
    $orderData['tel'] = (string)$user['tel'];
    $orderData['address'] = $userInfo ? (string)$userInfo['address'] : null;
    $orderData['balance'] = (string)$user['balance'];
    $orderData['completedquantity'] = $completedCount;
    $orderData['group_data'] = [$orderData];

    return $orderData;
  }

  protected function normalizeOrderListStatus($status)
  {
    if ($status === 2) {
      return 'pending';
    }
    if ($status === 1) {
      return 'completed';
    }
    if ($status === 0) {
      return 'all';
    }
    if ($status === -1) {
      return 'all_with_unpaid';
    }
    return null;
  }

  protected function formatApiOrderStatus($dbStatus)
  {
    return (int)$dbStatus === 2 ? 1 : 2;
  }

  protected function formatApiOrderStatusNameByDb($dbStatus)
  {
    return (int)$dbStatus === 2 ? __('miniapp.order_status_completed') : __('miniapp.order_status_pending');
  }

  /**
   * 订单列表 - 对齐线上字段
   * status: 0=全部(待完成), 1=待完成, 2=已完成, -1=全部(含未支付)
   * 线上返回: {status, page, size, balance, list[{oid,id,uid,...全字段}], paging}
   */
  public function orderRecord()
  {
    $this->execute(function () {
      $user = $this->getMiniappUser();
      $page   = max(1, (int)$this->request->param('page', 1));
      $size   = max(1, min(100, (int)$this->request->param('size', 10)));
      $status = (int)$this->request->param('status', self::ORDER_STATUS_ALL);
      $statusType = $this->normalizeOrderListStatus($status);
      if ($statusType === null) {
        $this->apiError(__('miniapp.order_status_invalid'), null, 400);
      }

      // 构建筛选条件闭包
      $applyFilter = function ($q) use ($user, $statusType) {
        $q->where('user_id', (int)$user['id']);
        if ($statusType === 'pending') {
          $q->where('status', 'in', [0, 1]);
        } elseif ($statusType === 'completed') {
          $q->where('status', 2);
        } elseif ($statusType === 'all_with_unpaid') {
          $q->where('status', 'in', [0, 1, 2]);
        }
      };

      $countQuery = Db::name('miniapp_order');
      $applyFilter($countQuery);
      $total = (int)$countQuery->count();

      $listQuery = Db::name('miniapp_order');
      $applyFilter($listQuery);
      $rows = $listQuery->order('id desc')->page($page, $size)->select();

      // 计算 time_limit
      $now = time();
      $list = [];
      foreach (($rows ?: []) as $row) {
        $dbStatus = (int)($row['status'] ?? 0);
        $row['oid']        = (int)$row['id'];
        $row['id']         = (string)$row['order_no'];
        $row['uid']        = (int)$row['user_id'];
        $row['status']     = $this->formatApiOrderStatus($dbStatus);
        $row['status_name'] = $this->formatApiOrderStatusNameByDb($dbStatus);
        $row['goods_count'] = max(1, (int)($row['goods_count'] ?? 1));
        $row['goods_price'] = isset($row['goods_price']) ? (string)$row['goods_price'] : '0.00';
        $row['time_limit'] = (int)$row['endtime'] > 0 ? (int)$row['endtime'] - $now : 0;
        $list[] = $row;
      }

      $paging = ($page * $size < $total) ? 1 : 0;

      $this->logRequest((int)$user['id']);
      $this->apiSuccess(__('miniapp.success'), [
        'status'  => $status,
        'page'    => $page,
        'size'    => $size,
        'balance' => (string)$user['balance'],
        'list'    => $list,
        'paging'  => $paging,
      ]);
    });
  }

  /**
   * 订单详情 - 对齐线上字段
   * 入参: id=订单号
   * 线上返回: {oid,commission,addtime,endtime(格式化),status,num,...,balance,yuji,completedquantity} + group_data[...]
   */
  public function order_info()
  {
    $this->execute(function () {
      $user = $this->getMiniappUser();
      $id = (string)$this->request->param('id', '');
      if ($id === '') {
        $this->apiError(__('miniapp.param_error'), null, 400);
      }

      $record = Db::name('miniapp_order')
        ->where('user_id', (int)$user['id'])
        ->where('order_no', $id)
        ->find();
      if (!$record) {
        $previewOrder = $this->resolvePreviewOrderInfo($user, $id);
        if ($previewOrder) {
          $this->logRequest((int)$user['id']);
          $this->apiSuccess(__('miniapp.success'), $previewOrder);
        }
        $this->apiError(__('miniapp.order_not_found'), null, 404);
      }

      // 查用户资料
      $userInfo = Db::name('miniapp_user_info')->where('user_id', (int)$user['id'])->find();

      $completedCount = (int)Db::name('miniapp_order')
        ->where('user_id', (int)$user['id'])
        ->where('status', 2)
        ->count();

      $yuji = (float)$record['num'] + (float)$record['commission'];

      $orderData = [
        'oid'             => (string)$record['order_no'],
        'commission'      => (string)$record['commission'],
        'addtime'         => (int)$record['addtime'],
        'endtime'         => $record['endtime'] ? date('Y/m/d H:i:s', (int)$record['endtime']) : '',
        'status'          => $this->formatApiOrderStatus($record['status']),
        'num'             => (string)$record['num'],
        'goods_count'     => max(1, (int)($record['goods_count'] ?? 1)),
        'add_id'          => (int)$record['add_id'],
        'goods_name'      => (string)$record['goods_name'],
        'goods_price'     => (string)$record['goods_price'],
        'shop_name'       => (string)$record['shop_name'],
        'goods_pic'       => (string)$record['goods_pic'],
        'name'            => $userInfo ? (string)$userInfo['realname'] : null,
        'tel'             => (string)$user['tel'],
        'address'         => $userInfo ? (string)$userInfo['address'] : null,
        'balance'         => (string)$user['balance'],
        'group_rule_num'  => (int)$record['group_rule_num'],
        'group_id'        => (int)$record['group_id'],
        'rands'           => $record['rands'],
        'group_count'     => $record['group_count'],
        'duorw'           => (int)$record['duorw'],
        'is_pay'          => (int)$record['is_pay'],
        'group_is_active' => (int)$record['group_is_active'],
        'yuji'            => $yuji,
        'completedquantity' => $completedCount,
      ];

      // group_data: 和 order_info 一样结构的数组
      $groupData = [$orderData];

      $this->logRequest((int)$user['id']);
      $resp = $orderData;
      $resp['group_data'] = $groupData;
      // 线上用 info 字段但我们统一用 msg
      $this->apiSuccess(__('miniapp.success'), $resp);
    });
  }

  /**
   * 完成订单 - 对齐线上逻辑
   * 入参: oid=订单号
   */
  public function do_order()
  {
    $this->execute(function () {
      $user = $this->getMiniappUser();
      $oid = (string)$this->request->param('oid', '');
      if ($oid === '') {
        $this->apiError(__('miniapp.param_error'), null, 400);
      }

      $record = Db::name('miniapp_order')
        ->where('user_id', (int)$user['id'])
        ->where(function ($query) use ($oid) {
          $query->where('order_no', $oid);
          if (ctype_digit($oid)) {
            $query->whereOr('id', (int)$oid);
          }
        })
        ->find();
      if (!$record) {
        $this->apiError(__('miniapp.order_not_found'), null, 404);
      }
      if ((int)$record['status'] === 2) {
        $this->apiError(__('miniapp.order_already_completed'), null, 400);
      }

      $now = time();
      $commission = (float)$record['commission'];

      Db::startTrans();
      try {
        Db::name('miniapp_order')->where('id', (int)$record['id'])->update([
          'status' => 2,
          'c_status' => 1,
          'complete_time' => $now,
          'update_time' => $now
        ]);
        Db::name('miniapp_order_action_log')->insert([
          'user_id' => (int)$user['id'],
          'order_id' => (int)$record['id'],
          'order_no' =>$oid,
          'action' => 'do_order',
          'amount' => (float)$record['amount'],
          'status' => 1,
          'create_time' => $now,
        ]);
        // 佣金入账
        Db::name('miniapp_user')->where('id', (int)$user['id'])->setInc('balance', $commission);
        $newBalance = (float)$user['balance'] + $commission;
        Db::name('miniapp_finance_log')->insert([
          'user_id' => (int)$user['id'],
          'uid' => (int)$user['id'],
          'sid' => (int)$user['id'],
          'oid' =>$oid,
          'type' => 3,
          'amount' => $commission,
          'num' => (string)$commission,
          'balance' => $newBalance,
          'balance_after' => $newBalance,
          'related_order_no' =>$oid,
          'addtime' => $now,
          'remark' => 'order complete commission',
          'status' => 1,
          'create_time' => $now,
        ]);
        Db::commit();
      } catch (\Throwable $e) {
        Db::rollback();
        $this->apiError(__('miniapp.operation_failed'), null, 500);
      }

      $this->logRequest((int)$user['id']);
      $this->apiSuccess(__('miniapp.success'), ['order_no' =>$oid, 'status' => 2]);
    });
  }
}
