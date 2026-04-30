<?php

namespace app\api\controller\miniapp;

use think\Db;

class My extends MiniappBase
{
  /**
   * 我的主页 - 对齐线上字段
   * 线上返回: {info:{username,tel,level,id,headpic,balance,freeze_balance,invite_code,show_td}}
   */
  public function indexNew()
  {
    $this->execute(function () {
      $user = $this->getMiniappUser();

      $this->logRequest((int)$user['id']);
      $this->apiSuccess(__('miniapp.success'), [
        'info' => [
          'username'       => (string)($user['username'] ?: $user['nickname']),
          'tel'            => (string)$user['tel'],
          'level'          => (int)($user['level'] ?? 0),
          'id'             => (int)$user['id'],
          'headpic'        => (string)($user['headpic'] ?? $user['avatar']),
          'balance'        => (string)$user['balance'],
          'freeze_balance' => (string)($user['freeze_balance'] ?? '0.00'),
          'invite_code'    => (string)$user['invite_code'],
          'show_td'        => (int)($user['show_td'] ?? 1),
        ],
      ]);
    });
  }

  /**
   * 用户资料 - 对齐线上字段
   * 线上返回: {info:{balance, username, tel, usdt_diz}}
   */
  public function userInfo()
  {
    $this->execute(function () {
      $user = $this->getMiniappUser();
      $info = Db::name('miniapp_user_info')->where('user_id', (int)$user['id'])->find();

      $this->logRequest((int)$user['id']);
      $this->apiSuccess(__('miniapp.success'), [
        'info' => [
          'balance'  => (string)$user['balance'],
          'username' => (string)($user['username'] ?: $user['nickname']),
          'tel'      => (string)$user['tel'],
          'usdt_diz' => (string)($info ? ($info['usdt_diz'] ?: $info['usdt_address']) : ''),
        ],
      ]);
    });
  }

  /**
   * 保存用户资料(修改密码/地址)
   */
  public function uinfoSave()
  {
    $this->execute(function () {
      $user = $this->getMiniappUser();
      $pwd    = (string)$this->request->param('pwd', '');
      $pwdNew = (string)$this->request->param('pwd_new', '');
      $address = (string)$this->request->param('address', '');
      $usdtDiz = (string)$this->request->param('usdt_diz', '');

      if ($pwd === '') {
        $this->apiError(__('miniapp.param_error'), null, 400);
      }
      if (md5($pwd) !== (string)$user['password']) {
        $this->apiError(__('miniapp.password_error'), null, 400);
      }

      $now = time();
      Db::startTrans();
      try {
        $exists = Db::name('miniapp_user_info')->where('user_id', (int)$user['id'])->lock(true)->find();
        $updateData = ['update_time' => $now];
        if ($address !== '') $updateData['address'] = $address;
        if ($usdtDiz !== '') $updateData['usdt_diz'] = $usdtDiz;

        if ($exists) {
          Db::name('miniapp_user_info')->where('user_id', (int)$user['id'])->update($updateData);
        } else {
          $updateData['user_id'] = (int)$user['id'];
          $updateData['create_time'] = $now;
          Db::name('miniapp_user_info')->insert($updateData);
        }
        if ($pwdNew !== '') {
          Db::name('miniapp_user')->where('id', (int)$user['id'])->update([
            'password' => md5($pwdNew),
            'update_time' => $now
          ]);
        }
        Db::name('miniapp_user_info_save_log')->insert([
          'user_id' => (int)$user['id'],
          'address' => $address,
          'has_new_pwd' => $pwdNew !== '' ? 1 : 0,
          'create_time' => $now,
        ]);
        Db::commit();
      } catch (\Throwable $e) {
        Db::rollback();
        $this->apiError(__('miniapp.operation_failed'), null, 500);
      }

      $this->logRequest((int)$user['id']);
      $this->apiSuccess(__('miniapp.success'));
    });
  }

  /**
   * 资金流水 - 对齐线上字段
   * 线上返回: {page, size, start, end, list[{id,uid,sid,oid,num,balance,type,status,addtime,f_lv}], paging}
   * type筛选: 9=全部, 1=入金(type in 1,3), 7=出金(type=7)
   */
  public function caiwu()
  {
    $this->execute(function () {
      $user = $this->getMiniappUser();
      $page  = max(1, (int)$this->request->param('page', 1));
      $size  = max(1, min(100, (int)$this->request->param('size', 10)));
      $type  = (int)$this->request->param('type', 9);
      $start = (string)$this->request->param('start', '');
      $end   = (string)$this->request->param('end', '');

      // 构建筛选条件闭包
      $applyFilter = function ($q) use ($user, $type, $start, $end) {
        $q->where('user_id', (int)$user['id']);
        if ($type === 1) {
          $q->where('type', 'in', [1, 3]);
        } elseif ($type === 7) {
          $q->where('type', 7);
        }
        if ($start !== '') {
          $q->where('create_time', '>=', strtotime($start));
        }
        if ($end !== '') {
          $q->where('create_time', '<=', strtotime($end) + 86400);
        }
      };

      $countQuery = Db::name('miniapp_finance_log');
      $applyFilter($countQuery);
      $total = (int)$countQuery->count();

      $listQuery = Db::name('miniapp_finance_log');
      $applyFilter($listQuery);
      $rows = $listQuery->field('id, uid, sid, oid, num, balance, type, status, addtime, f_lv')
        ->order('id desc')->page($page, $size)->select();

      $paging = ($page * $size < $total) ? 1 : 0;

      $this->logRequest((int)$user['id']);
      $this->apiSuccess(__('miniapp.success'), [
        'page'   => (string)$page,
        'size'   => (string)$size,
        'start'  => $start,
        'end'    => $end,
        'list'   => $rows ?: [],
        'paging' => $paging,
      ]);
    });
  }

  /**
   * 设置资金密码
   */
  public function setCashPwd()
  {
    $this->execute(function () {
      $user = $this->getMiniappUser();
      $pwd = (string)$this->request->param('pwd', '');
      $pwdNew = (string)$this->request->param('pwd_new', '');
      $pwdNewConfirm = (string)$this->request->param('pwd_new_confirm', '');
      $address = (string)$this->request->param('address', '');
      if ($pwd === '' || $pwdNew === '' || $pwdNewConfirm === '') {
        $this->apiError(__('miniapp.param_error'), null, 400);
      }
      if (md5($pwd) !== (string)$user['password']) {
        $this->apiError(__('miniapp.password_error'), null, 400);
      }
      if ($pwdNew !== $pwdNewConfirm) {
        $this->apiError(__('miniapp.password_confirm_failed'), null, 400);
      }
      $now = time();
      Db::name('miniapp_user')->where('id', (int)$user['id'])->update([
        'cash_password' => md5($pwdNew),
        'update_time' => $now
      ]);
      Db::name('miniapp_cashpwd_log')->insert([
        'user_id' => (int)$user['id'],
        'address' => $address,
        'create_time' => $now
      ]);
      $this->logRequest((int)$user['id']);
      $this->apiSuccess(__('miniapp.success'));
    });
  }
}
