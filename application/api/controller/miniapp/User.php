<?php

namespace app\api\controller\miniapp;

use think\Db;

class User extends MiniappBase
{
  /**
   * 用户登录。
   */
  public function do_login()
  {
    $this->execute(function () {
      $tel = (string)$this->request->post('tel', $this->request->param('tel', ''));
      $pwd = (string)$this->request->post('pwd', $this->request->param('pwd', ''));
      if ($tel === '' || $pwd === '') {
        $this->apiError(__('miniapp.param_error'), null, 400);
      }

      $user = Db::name('miniapp_user')->where('tel', $tel)->where('status', 1)->find();
      if (!$user || $user['password'] !== md5($pwd)) {
        $this->apiError(__('miniapp.login_failed'), null, 401);
      }

      $token = md5($user['id'] . '_' . $tel . '_' . microtime(true) . '_' . mt_rand(1000, 9999));
      $now = time();
      Db::name('miniapp_user')
        ->where('id', (int)$user['id'])
        ->update([
          'token'           => $token,
          'last_login_time' => $now,
          'last_login_ip'   => (string)$this->request->ip(),
          'update_time'     => $now,
        ]);

      Db::name('miniapp_user_login_log')->insert([
        'user_id'     => (int)$user['id'],
        'tel'         => $tel,
        'token'       => $token,
        'client_ip'   => (string)$this->request->ip(),
        'create_time' => $now,
      ]);

      $this->logRequest((int)$user['id']);
      $this->apiSuccess(__('miniapp.success'), [
        'token'           => $token,
        'token_expire_at' => $this->getTokenExpireAt($now),
        'userinfo'        => [
          'id'       => (int)$user['id'],
          'tel'      => (string)$user['tel'],
          'nickname' => (string)$user['nickname'],
          'avatar'   => (string)$user['avatar'],
          'balance'  => (float)$user['balance'],
        ],
      ]);
    });
  }

  /**
   * 用户注册。
   */
  public function do_register()
  {
    $this->execute(function () {
      $tel = (string)$this->request->post('tel', $this->request->param('tel', ''));
      $pwd = (string)$this->request->post('pwd', $this->request->param('pwd', ''));
      $confirmPassword = (string)$this->request->post('confirmPassword', $this->request->param('confirmPassword', ''));
      $inviteCode = (string)$this->request->post('invite_code', $this->request->param('invite_code', ''));
      $areaCode = (string)$this->request->post('area_code', $this->request->param('area_code', ''));
      if ($tel === '' || $pwd === '' || $confirmPassword === '' || $inviteCode === '' || $areaCode === '') {
        $this->apiError(__('miniapp.param_error'), null, 400);
      }
      if ($pwd !== $confirmPassword) {
        $this->apiError(__('miniapp.password_confirm_failed'), null, 400);
      }
      if (Db::name('miniapp_user')->where('tel', $tel)->find()) {
        $this->apiError(__('miniapp.tel_exists'), null, 400);
      }

      $parentUser = Db::name('miniapp_user')->where('invite_code', $inviteCode)->where('show_td', 1)->find();
      if (!$parentUser) {
        $this->apiError(__('miniapp.invite_code_invalid'), null, 400);
      }
      $now = time();
      $token = md5($tel . '_' . microtime(true) . '_' . mt_rand(1000, 9999));
      $newInviteCode = strtoupper(substr(md5($tel . $now), 0, 8));
      $userId = Db::name('miniapp_user')->insertGetId([
        'tel'             => $tel,
        'password'        => md5($pwd),
        'cash_password'   => md5($pwd),
        'token'           => $token,
        'nickname'        => 'U' . substr($tel, -4),
        'avatar'          => '',
        'balance'         => 0,
        'team_income'     => 0,
        'invite_code'     => $newInviteCode,
        'parent_id'       => $parentUser ? (int)$parentUser['id'] : 0,
        'area_code'       => $areaCode,
        'status'          => 1,
        'last_login_time' => $now,
        'last_login_ip'   => (string)$this->request->ip(),
        'create_time'     => $now,
        'update_time'     => $now,
      ]);
      Db::name('miniapp_user_register_log')->insert([
        'user_id'          => $userId,
        'tel'              => $tel,
        'token'            => $token,
        'invite_code'      => $inviteCode,
        'area_code'        => $areaCode,
        'confirm_password' => $confirmPassword,
        'client_ip'        => (string)$this->request->ip(),
        'create_time'      => $now,
      ]);
      Db::name('miniapp_user_info')->insert([
        'user_id'     => $userId,
        'create_time' => $now,
        'update_time' => $now,
      ]);

      $this->logRequest((int)$userId);
      $this->apiSuccess(__('miniapp.success'), [
        'token'           => $token,
        'token_expire_at' => $this->getTokenExpireAt($now),
        'userinfo'        => [
          'id'          => (int)$userId,
          'tel'         => $tel,
          'invite_code' => $newInviteCode,
          'parent_id'   => $parentUser ? (int)$parentUser['id'] : 0,
          'area_code'   => $areaCode,
        ],
      ]);
    });
  }

  /**
   * 退出登录。
   */
  public function logout()
  {
    $this->execute(function () {
      $user = $this->getMiniappUser();
      $now = time();
      Db::name('miniapp_user_logout_log')->insert([
        'user_id'     => (int)$user['id'],
        'token'       => (string)$this->getToken(),
        'create_time' => $now,
      ]);
      Db::name('miniapp_user')->where('id', (int)$user['id'])->update(['token' => '', 'update_time' => $now]);
      $this->logRequest((int)$user['id']);
      $this->apiSuccess(__('miniapp.success'));
    });
  }
}
