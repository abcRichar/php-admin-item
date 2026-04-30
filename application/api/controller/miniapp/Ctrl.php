<?php

namespace app\api\controller\miniapp;

use think\Db;

class Ctrl extends MiniappBase
{
  /**
   * 团队信息 - 对齐线上字段
   * 线上返回: {team1_count, team1_rebate, team1_rebate_day, list:{}}
   */
  public function teamAll()
  {
    $this->execute(function () {
      $user = $this->getMiniappUser();

      // 一级团队成员数
      $team1Count = (int)Db::name('miniapp_user')
        ->where('parent_id', (int)$user['id'])->count();

      // 一级团队总返佣
      $team1Rebate = (float)Db::name('miniapp_finance_log')
        ->where('user_id', (int)$user['id'])
        ->where('type', 4)
        ->sum('amount');

      // 今日团队返佣
      $todayStart = strtotime(date('Y-m-d'));
      $team1RebateDay = (float)Db::name('miniapp_finance_log')
        ->where('user_id', (int)$user['id'])
        ->where('type', 4)
        ->where('create_time', '>=', $todayStart)
        ->sum('amount');

      // 成员列表
      $members = Db::name('miniapp_user')
        ->where('parent_id', (int)$user['id'])
        ->field('id, tel, nickname, username, balance, create_time')
        ->order('id desc')
        ->select();

      $list = new \stdClass();
      if ($members) {
        $list = $members;
      }

      $this->logRequest((int)$user['id']);
      $this->apiSuccess(__('miniapp.success'), [
        'team1_count'      => $team1Count,
        'team1_rebate'     => $team1Rebate,
        'team1_rebate_day' => $team1RebateDay,
        'list'             => $list,
      ]);
    });
  }

  /**
   * 提现申请 - 对齐线上逻辑(未完成订单检查)
   */
  public function do_withdraw()
  {
    $this->execute(function () {
      $user = $this->getMiniappUser();

      // 检查未完成订单
      $undone = Db::name('miniapp_order')
        ->where('user_id', (int)$user['id'])
        ->where('status', 'in', [0, 1])
        ->find();
      if ($undone) {
        $this->apiError(__('miniapp.has_undone_order'), null, 400);
      }

      $num = (float)$this->request->param('num', 0);
      $type = (string)$this->request->param('type', '');
      $paypassword = (string)$this->request->param('paypassword', '');
      if ($num <= 0 || $type === '' || $paypassword === '') {
        $this->apiError(__('miniapp.param_error'), null, 400);
      }
      if (md5($paypassword) !== (string)$user['cash_password']) {
        $this->apiError(__('miniapp.cash_password_error'), null, 400);
      }
      if ((float)$user['balance'] < $num) {
        $this->apiError(__('miniapp.balance_not_enough'), null, 400);
      }

      $now = time();
      $withdrawNo = 'WD' . date('ymdHis') . mt_rand(1000, 9999);
      Db::startTrans();
      try {
        $affected = Db::name('miniapp_user')->where('id', (int)$user['id'])
          ->where('balance', '>=', $num)->setDec('balance', $num);
        if (!$affected) throw new \RuntimeException('balance not enough');
        Db::name('miniapp_withdraw')->insert([
          'user_id' => (int)$user['id'],
          'withdraw_no' => $withdrawNo,
          'type' => $type,
          'amount' => $num,
          'status' => 1,
          'create_time' => $now,
          'update_time' => $now,
        ]);
        $newBalance = (float)$user['balance'] - $num;
        Db::name('miniapp_finance_log')->insert([
          'user_id' => (int)$user['id'],
          'uid' => (int)$user['id'],
          'sid' => (int)$user['id'],
          'oid' => $withdrawNo,
          'type' => 7,
          'amount' => -$num,
          'num' => (string)(-$num),
          'balance' => $newBalance,
          'balance_after' => $newBalance,
          'related_order_no' => $withdrawNo,
          'addtime' => $now,
          'remark' => 'withdraw apply',
          'status' => 1,
          'create_time' => $now,
        ]);
        Db::commit();
      } catch (\Throwable $e) {
        Db::rollback();
        $this->apiError(__('miniapp.operation_failed'), null, 500);
      }

      $this->logRequest((int)$user['id']);
      $this->apiSuccess(__('miniapp.success'), ['withdraw_no' => $withdrawNo, 'amount' => $num]);
    });
  }

  /**
   * 充值通道 - 对齐线上字段
   * 线上返回: {usercode, pay[{usercode, type}]}
   */
  public function rechargeNew()
  {
    $this->execute(function () {
      $user = $this->getMiniappUser();
      $payConfigs = Db::name('miniapp_pay_config')
        ->where('status', 1)
        ->where(function ($q) use ($user) {
          $q->where('user_id', 0)->whereOr('user_id', (int)$user['id']);
        })
        ->order('sort desc, id desc')
        ->field('usercode, type')
        ->select();

      $usercode = $payConfigs ? (string)$payConfigs[0]['usercode'] : '';

      $this->logRequest((int)$user['id']);
      $this->apiSuccess(__('miniapp.success'), [
        'usercode' => $usercode,
        'pay'      => $payConfigs ?: [],
      ]);
    });
  }
}
