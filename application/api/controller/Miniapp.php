<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\model\MiniappHome;
use think\Db;
use think\exception\HttpResponseException;
use think\Lang;

class Miniapp extends Api
{
    const ORDER_STATUS_ALL = 0;
    const ORDER_STATUS_PENDING = 1;
    const ORDER_STATUS_COMPLETED = 2;
    const LANGUAGE_CN = 1;
    const LANGUAGE_EN = 2;
    const TOKEN_EXPIRE_SECONDS = 2592000;

    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];
    protected $miniappLanguage = null;

    /**
     * 初始化 miniapp 控制器并加载对应语言包。
     */
    protected function _initialize()
    {
        $this->miniappLanguage = $this->resolveLanguageConfig(true);
        parent::_initialize();
        Lang::range($this->miniappLanguage['langset']);
        Lang::load(APP_PATH . 'api/lang/' . $this->miniappLanguage['langset'] . '/miniapp.php');
    }

    /**
     * 获取客服/全局支持信息。
     */
    public function supportIndex()
    {
        $this->execute(function () {
            $language = $this->getLanguageValue();
            $rows = Db::name('miniapp_support')
                ->where('status', 1)
                ->where('language', $language)
                ->order('sort desc,id desc')
                ->select();
            if (!$rows && $language !== self::LANGUAGE_CN) {
                $rows = Db::name('miniapp_support')
                    ->where('status', 1)
                    ->where('language', self::LANGUAGE_CN)
                    ->order('sort desc,id desc')
                    ->select();
            }
            $first = $rows ? $rows[0] : null;
            $resolvedLanguage = $first ? (int)$first['language'] : $language;

            $this->logRequest(0);
            $this->apiSuccess(__('miniapp.success'), [
                'language'      => $resolvedLanguage,
                'language_name' => $this->getLanguageName($resolvedLanguage),
                'contact'       => $first ? [
                    'id'            => (int)$first['id'],
                    'title'         => (string)$first['title'],
                    'content'       => (string)$first['content'],
                    'contact_type'  => (string)$first['contact_type'],
                    'contact_value' => (string)$first['contact_value'],
                ] : new \stdClass(),
            ]);
        });
    }

    /**
     * 设置语言，1=中文，2=英文。
     */
    public function setLanguage()
    {
        $this->execute(function () {
            $languageInput = $this->request->post('language', $this->request->param('language', ''));
            if ($languageInput === '' || $languageInput === null) {
                $this->apiError(__('miniapp.language_required'), null, 400);
            }

            $languageConfig = $this->normalizeLanguage($languageInput);
            if (!$languageConfig) {
                $this->apiError(__('miniapp.language_invalid'), null, 400);
            }

            $this->miniappLanguage = $languageConfig;
            Lang::range($languageConfig['langset']);
            Lang::load(APP_PATH . 'api/lang/' . $languageConfig['langset'] . '/miniapp.php');

            $user = $this->getMiniappUser(false);
            Db::name('miniapp_support_language_log')->insert([
                'user_id'     => $user ? (int)$user['id'] : 0,
                'language'    => $languageConfig['value'],
                'token'       => $this->getToken(),
                'create_time' => time(),
            ]);

            $this->logRequest($user ? (int)$user['id'] : 0);
            $this->apiSuccess(__('miniapp.success'), [
                'language'      => $languageConfig['value'],
                'language_name' => $this->getLanguageName($languageConfig['value']),
            ]);
        });
    }

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
     * 获取首页配置。
     */
    public function homeNew()
    {
        $this->execute(function () {
            if (!$this->request->isGet() && !$this->request->isPost()) {
                $this->apiError(__('miniapp.method_not_allowed'), null, 405);
            }

            $user = $this->getMiniappUser();
            $language = $this->getLanguageValue();
            $token = $this->getToken();
            $home = MiniappHome::getActiveHome($language);
            if (!$home) {
                $this->apiError(__('miniapp.home_not_found'), null, 404);
            }

            $this->logRequest((int)$user['id']);

            $this->apiSuccess(__('miniapp.success'), [
                'id'             => (int)$home->id,
                'name'           => (string)$home->name,
                'language'       => $language,
                'language_name'  => $this->getLanguageName($language),
                'token'          => $token,
                'title'          => (string)$home->title,
                'subtitle'       => (string)$home->subtitle,
                'banner_list'    => $home->banner_list,
                'notice_list'    => $home->notice_list,
                'nav_list'       => $home->nav_list,
                'recommend_list' => $home->recommend_list,
                'popup_list'     => $home->popup_list,
                'extra'          => $home->extra,
                'server_time'    => time(),
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

            $parentUser = Db::name('miniapp_user')->where('invite_code', $inviteCode)->find();
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
     * 获取订单列表。
     */
    public function orderRecord()
    {
        $this->execute(function () {
            $user = $this->getMiniappUser();
            $page = max(1, (int)$this->request->param('page', 1));
            $size = max(1, min(100, (int)$this->request->param('size', 10)));
            $status = (int)$this->request->param('status', self::ORDER_STATUS_ALL);
            if (!in_array($status, [self::ORDER_STATUS_ALL, self::ORDER_STATUS_PENDING, self::ORDER_STATUS_COMPLETED], true)) {
                $this->apiError(__('miniapp.order_status_invalid'), null, 400);
            }

            $countQuery = Db::name('miniapp_order')->where('user_id', (int)$user['id']);
            $countQuery = $this->applyOrderStatusFilter($countQuery, $status);
            $total = (int)$countQuery->count();

            $listQuery = Db::name('miniapp_order')->where('user_id', (int)$user['id']);
            $listQuery = $this->applyOrderStatusFilter($listQuery, $status);
            $rows = $listQuery->order('id desc')->page($page, $size)->select();
            $rows = $this->formatOrderRows($rows ?: []);

            $this->logRequest((int)$user['id']);
            $this->apiSuccess(__('miniapp.success'), [
                'page'        => $page,
                'size'        => $size,
                'status'      => $status,
                'status_name' => $this->getOrderStatusName($status),
                'total'       => $total,
                'list'        => $rows,
            ]);
        });
    }

    /**
     * 获取商品信息。
     */
    public function orderInfo()
    {
        $this->execute(function () {
            $user = $this->getMiniappUser();
            $language = $this->getLanguageValue();
            $rows = Db::name('miniapp_goods')
                ->where('status', 1)
                ->where('language', $language)
                ->order('sort desc,id desc')
                ->select();
            if (!$rows && $language !== self::LANGUAGE_CN) {
                $rows = Db::name('miniapp_goods')->where('status', 1)->where('language', self::LANGUAGE_CN)->order('sort desc,id desc')->select();
            }
            foreach (($rows ?: []) as &$row) {
                $row['goods_count'] = max(1, (int)($row['goods_count'] ?? 1));
            }
            unset($row);
            $this->logRequest((int)$user['id']);
            $this->apiSuccess(__('miniapp.success'), ['list' => $rows ?: []]);
        });
    }

    /**
     * 获取订单详情。
     */
    public function order_info()
    {
        $this->execute(function () {
            $user = $this->getMiniappUser();
            $id = (string)$this->request->post('id', $this->request->param('id', ''));
            if ($id === '') {
                $this->apiError(__('miniapp.param_error'), null, 400);
            }

            $record = Db::name('miniapp_order')->where('user_id', (int)$user['id'])->where('order_no', $id)->find();
            if (!$record) {
                $this->apiError(__('miniapp.order_not_found'), null, 404);
            }

            $detail = Db::name('miniapp_order')->where('order_no', $id)->find();
            $this->logRequest((int)$user['id']);
            $this->apiSuccess(__('miniapp.success'), ['record' => $record, 'detail' => $detail ?: new \stdClass()]);
        });
    }

    /**
     * 完成订单。
     */
    public function do_order()
    {
        $this->execute(function () {
            $user = $this->getMiniappUser();
            $oid = (string)$this->request->post('oid', $this->request->param('oid', ''));
            if ($oid === '') {
                $this->apiError(__('miniapp.param_error'), null, 400);
            }

            $record = Db::name('miniapp_order')->where('user_id', (int)$user['id'])->where('order_no', $oid)->find();
            if (!$record) {
                $this->apiError(__('miniapp.order_not_found'), null, 404);
            }
            if ((int)$record['status'] === 2) {
                $this->apiError(__('miniapp.order_already_completed'), null, 400);
            }

            $now = time();
            Db::name('miniapp_order')->where('id', (int)$record['id'])->update(['status' => 2, 'complete_time' => $now, 'update_time' => $now]);
            Db::name('miniapp_order_action_log')->insert(['user_id' => (int)$user['id'], 'order_id' => (int)$record['id'], 'order_no' => $oid, 'action' => 'do_order', 'amount' => (float)$record['amount'], 'status' => 1, 'create_time' => $now]);
            Db::name('miniapp_user')->where('id', (int)$user['id'])->setInc('balance', (float)$record['amount']);

            Db::name('miniapp_finance_log')->insert([
                'user_id'          => (int)$user['id'],
                'type'             => 1,
                'amount'           => (float)$record['amount'],
                'balance_after'    => (float)$user['balance'] + (float)$record['amount'],
                'related_order_no' => $oid,
                'remark'           => 'order complete income',
                'create_time'      => $now,
            ]);

            $this->logRequest((int)$user['id']);
            $this->apiSuccess(__('miniapp.success'), ['order_no' => $oid, 'status' => 2]);
        });
    }

    /**
     * 提交订单。
     */
    public function submit_order()
    {
        $this->execute(function () {
            $user = $this->getMiniappUser();
            $goods = Db::name('miniapp_goods')->where('status', 1)->where('language', $this->getLanguageValue())->order('sort desc,id asc')->find();
            if (!$goods) {
                $goods = Db::name('miniapp_goods')->where('status', 1)->where('language', self::LANGUAGE_CN)->order('sort desc,id asc')->find();
            }
            if (!$goods) {
                $this->apiError(__('miniapp.goods_not_found'), null, 404);
            }

            $now = time();
            $orderNo = 'UB' . date('ymdHis') . mt_rand(1000, 9999);
            $goodsCount = max(1, (int)($goods['goods_count'] ?? 1));
            $goodsPrice = (float)$goods['price'];
            $amount = round($goodsPrice * $goodsCount, 2);
            Db::startTrans();
            try {
                $orderId = Db::name('miniapp_order')->insertGetId([
                    'user_id'      => (int)$user['id'],
                    'order_no'     => $orderNo,
                    'goods_id'     => (int)$goods['id'],
                    'goods_count'  => $goodsCount,
                    'goods_name'   => (string)$goods['title'],
                    'shop_name'    => (string)$goods['title'],
                    'goods_price'  => $goodsPrice,
                    'goods_pic'    => (string)$goods['image'],
                    'goods_image'  => (string)$goods['image'],
                    'amount'       => $amount,
                    'status'       => 1,
                    'source'       => 'submit_order',
                    'language'     => $this->getLanguageValue(),
                    'remark'       => '',
                    'pay_time'     => $now,
                    'complete_time' => 0,
                    'create_time'  => $now,
                    'update_time'  => $now,
                ]);
                Db::name('miniapp_order_action_log')->insert([
                    'user_id'      => (int)$user['id'],
                    'order_id'     => $orderId,
                    'order_no'     => $orderNo,
                    'action'       => 'submit_order',
                    'amount'       => $amount,
                    'status'       => 1,
                    'create_time'  => $now,
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

    /**
     * 获取团队信息。
     */
    public function teamAll()
    {
        $this->execute(function () {
            $user = $this->getMiniappUser();
            $summary = Db::name('miniapp_team')->where('user_id', (int)$user['id'])->find();
            $members = Db::name('miniapp_team_member')->where('user_id', (int)$user['id'])->order('id desc')->select();
            $this->logRequest((int)$user['id']);
            $this->apiSuccess(__('miniapp.success'), ['summary' => $summary ?: new \stdClass(), 'members' => $members ?: []]);
        });
    }

    /**
     * 提现申请。
     */
    public function do_withdraw()
    {
        $this->execute(function () {
            $user = $this->getMiniappUser();
            $num = (float)$this->request->post('num', $this->request->param('num', 0));
            $type = (string)$this->request->post('type', $this->request->param('type', ''));
            $paypassword = (string)$this->request->post('paypassword', $this->request->param('paypassword', ''));
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
                $affectedRows = Db::name('miniapp_user')
                    ->where('id', (int)$user['id'])
                    ->where('balance', '>=', $num)
                    ->setDec('balance', $num);
                if (!$affectedRows) {
                    throw new \RuntimeException('balance not enough');
                }
                Db::name('miniapp_withdraw')->insert([
                    'user_id'      => (int)$user['id'],
                    'withdraw_no'  => $withdrawNo,
                    'type'         => $type,
                    'amount'       => $num,
                    'status'       => 1,
                    'create_time'  => $now,
                    'update_time'  => $now,
                ]);
                Db::name('miniapp_finance_log')->insert([
                    'user_id'          => (int)$user['id'],
                    'type'             => 7,
                    'amount'           => -$num,
                    'balance_after'    => (float)$user['balance'] - $num,
                    'related_order_no' => $withdrawNo,
                    'remark'           => 'withdraw apply',
                    'create_time'      => $now,
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
     * 获取我的页面数据。
     */
    public function indexNew()
    {
        $this->execute(function () {
            $user = $this->getMiniappUser();
            $profile = Db::name('miniapp_profile')->where('user_id', (int)$user['id'])->find();
            $this->logRequest((int)$user['id']);
            $this->apiSuccess(__('miniapp.success'), [
                'profile' => $profile ?: new \stdClass(),
                'user'    => [
                    'id'          => (int)$user['id'],
                    'tel'         => (string)$user['tel'],
                    'nickname'    => (string)$user['nickname'],
                    'balance'     => (float)$user['balance'],
                    'team_income' => (float)$user['team_income'],
                ],
            ]);
        });
    }

    /**
     * 获取充值通道。
     */
    public function rechargeNew()
    {
        $this->execute(function () {
            $user = $this->getMiniappUser();
            $rows = Db::name('miniapp_recharge_channel')->where('status', 1)->order('sort desc,id desc')->select();
            $this->logRequest((int)$user['id']);
            $this->apiSuccess(__('miniapp.success'), ['balance' => (float)$user['balance'], 'channels' => $rows ?: []]);
        });
    }

    /**
     * 获取用户资料。
     */
    public function userInfo()
    {
        $this->execute(function () {
            $user = $this->getMiniappUser();
            $info = Db::name('miniapp_user_info')->where('user_id', (int)$user['id'])->find();
            $this->logRequest((int)$user['id']);
            $this->apiSuccess(__('miniapp.success'), ['userinfo' => $info ?: new \stdClass()]);
        });
    }

    /**
     * 保存用户资料。
     */
    public function uinfoSave()
    {
        $this->execute(function () {
            $user = $this->getMiniappUser();
            $address = (string)$this->request->post('address', $this->request->param('address', ''));
            $pwd = (string)$this->request->post('pwd', $this->request->param('pwd', ''));
            $pwdNew = (string)$this->request->post('pwd_new', $this->request->param('pwd_new', ''));
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
                if ($exists) {
                    Db::name('miniapp_user_info')->where('user_id', (int)$user['id'])->update(['address' => $address, 'update_time' => $now]);
                } else {
                    Db::name('miniapp_user_info')->insert([
                        'user_id'     => (int)$user['id'],
                        'address'     => $address,
                        'create_time' => $now,
                        'update_time' => $now,
                    ]);
                }
                if ($pwdNew !== '') {
                    Db::name('miniapp_user')->where('id', (int)$user['id'])->update(['password' => md5($pwdNew), 'update_time' => $now]);
                }
                Db::name('miniapp_user_info_save_log')->insert(['user_id' => (int)$user['id'], 'address' => $address, 'has_new_pwd' => $pwdNew !== '' ? 1 : 0, 'create_time' => $now]);
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
     * 获取财务流水。
     */
    public function caiwu()
    {
        $this->execute(function () {
            $user = $this->getMiniappUser();
            $page = max(1, (int)$this->request->post('page', $this->request->param('page', 1)));
            $size = max(1, min(100, (int)$this->request->post('size', $this->request->param('size', 10))));
            $type = (int)$this->request->post('type', $this->request->param('type', 0));
            $query = Db::name('miniapp_finance_log')->where('user_id', (int)$user['id']);
            if ($type > 0) {
                $query->where('type', $type);
            }
            $total = (int)$query->count();
            $rows = $query->order('id desc')->page($page, $size)->select();
            $this->logRequest((int)$user['id']);
            $this->apiSuccess(__('miniapp.success'), ['page' => $page, 'size' => $size, 'total' => $total, 'list' => $rows ?: []]);
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

    /**
     * 设置资金密码。
     */
    public function setCashPwd()
    {
        $this->execute(function () {
            $user = $this->getMiniappUser();
            $pwd = (string)$this->request->post('pwd', $this->request->param('pwd', ''));
            $pwdNew = (string)$this->request->post('pwd_new', $this->request->param('pwd_new', ''));
            $pwdNewConfirm = (string)$this->request->post('pwd_new_confirm', $this->request->param('pwd_new_confirm', ''));
            $address = (string)$this->request->post('address', $this->request->param('address', ''));
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
            Db::name('miniapp_user')->where('id', (int)$user['id'])->update(['cash_password' => md5($pwdNew), 'update_time' => $now]);
            Db::name('miniapp_cashpwd_log')->insert(['user_id' => (int)$user['id'], 'address' => $address, 'create_time' => $now]);
            $this->logRequest((int)$user['id']);
            $this->apiSuccess(__('miniapp.success'));
        });
    }

    /**
     * 获取当前语言标识，1=中文，2=英文。
     */
    protected function getLanguageValue()
    {
        if (!$this->miniappLanguage) {
            $this->miniappLanguage = $this->resolveLanguageConfig(true);
        }

        return (int)$this->miniappLanguage['value'];
    }

    protected function getToken()
    {
        return (string)$this->request->header('token', $this->request->param('token', ''));
    }

    protected function getMiniappUser($required = true)
    {
        $token = $this->getToken();
        if ($token === '') {
            if ($required) {
                $this->apiError(__('miniapp.login_required'), null, 401);
            }
            return null;
        }

        $user = Db::name('miniapp_user')->where('token', $token)->where('status', 1)->find();
        if ($user && $this->isTokenExpired($user)) {
            Db::name('miniapp_user')->where('id', (int)$user['id'])->update([
                'token'       => '',
                'update_time' => time(),
            ]);
            if ($required) {
                $this->apiError(__('miniapp.token_expired'), null, 401);
            }
            return null;
        }
        if (!$user && $required) {
            $this->apiError(__('miniapp.login_required'), null, 401);
        }
        return $user ?: null;
    }

    protected function logRequest($userId = 0)
    {
        try {
            Db::name('miniapp_request_log')->insert([
                'module'             => (string)$this->request->module(),
                'controller'         => (string)$this->request->controller(),
                'action'             => (string)$this->request->action(),
                'language'           => $this->getLanguageValue(),
                'token'              => $this->getToken(),
                'user_id'            => (int)$userId,
                'request_method'     => (string)$this->request->method(),
                'request_uri'        => (string)$this->request->url(),
                'accept'             => (string)$this->request->header('accept', ''),
                'accept_language'    => (string)$this->request->header('accept-language', ''),
                'content_type'       => (string)$this->request->header('content-type', ''),
                'origin'             => (string)$this->request->header('origin', ''),
                'priority'           => (string)$this->request->header('priority', ''),
                'referer'            => (string)$this->request->header('referer', ''),
                'sec_ch_ua'          => (string)$this->request->header('sec-ch-ua', ''),
                'sec_ch_ua_mobile'   => (string)$this->request->header('sec-ch-ua-mobile', ''),
                'sec_ch_ua_platform' => (string)$this->request->header('sec-ch-ua-platform', ''),
                'sec_fetch_dest'     => (string)$this->request->header('sec-fetch-dest', ''),
                'sec_fetch_mode'     => (string)$this->request->header('sec-fetch-mode', ''),
                'sec_fetch_site'     => (string)$this->request->header('sec-fetch-site', ''),
                'user_agent'         => (string)$this->request->header('user-agent', ''),
                'client_ip'          => (string)$this->request->ip(),
                'payload'            => json_encode($this->request->param(), JSON_UNESCAPED_UNICODE),
                'create_time'        => time(),
            ]);
        } catch (\Throwable $e) {
        }
    }

    /**
     * 统一执行接口逻辑并兜底 500 响应。
     */
    protected function execute(callable $callback)
    {
        try {
            $callback();
        } catch (HttpResponseException $e) {
            throw $e;
        } catch (\Throwable $e) {
            $this->apiError(__('miniapp.server_error'), null, 500);
        }
    }

    /**
     * miniapp 成功响应。
     */
    protected function apiSuccess($msg = '', $data = null)
    {
        $this->success($msg, $data, 200, null, ['statuscode' => 200]);
    }

    /**
     * miniapp 错误响应。
     */
    protected function apiError($msg = '', $data = null, $statusCode = 400)
    {
        $this->error($msg, $data, $statusCode, null, ['statuscode' => $statusCode]);
    }

    /**
     * 解析当前请求语言。
     */
    protected function resolveLanguageConfig($allowHistory = false)
    {
        $languageInput = $this->request->header('language', $this->request->param('language', ''));
        if ($languageInput !== '' && $languageInput !== null) {
            $language = $this->normalizeLanguage($languageInput);
            if (!$language) {
                $this->apiError(__('miniapp.language_invalid'), null, 400);
            }
            return $language;
        }

        if ($allowHistory) {
            $historyLanguage = $this->findHistoryLanguage();
            if ($historyLanguage !== null) {
                return $historyLanguage;
            }
        }

        return $this->normalizeLanguage(self::LANGUAGE_CN);
    }

    /**
     * 根据最近一次设置记录回读语言。
     */
    protected function findHistoryLanguage()
    {
        $token = $this->getToken();
        if ($token !== '') {
            $language = Db::name('miniapp_support_language_log')->where('token', $token)->order('id desc')->value('language');
            if ($language !== null && $language !== '') {
                return $this->normalizeLanguage($language);
            }

            $user = Db::name('miniapp_user')->where('token', $token)->where('status', 1)->find();
            if ($user) {
                $language = Db::name('miniapp_support_language_log')->where('user_id', (int)$user['id'])->order('id desc')->value('language');
                if ($language !== null && $language !== '') {
                    return $this->normalizeLanguage($language);
                }
            }
        }

        return null;
    }

    /**
     * 规范化语言输入。
     */
    protected function normalizeLanguage($language)
    {
        $language = strtolower(trim((string)$language));
        $map = [
            '1' => ['value' => self::LANGUAGE_CN, 'langset' => 'zh-cn'],
            'zh_cn' => ['value' => self::LANGUAGE_CN, 'langset' => 'zh-cn'],
            'zh-cn' => ['value' => self::LANGUAGE_CN, 'langset' => 'zh-cn'],
            'zh' => ['value' => self::LANGUAGE_CN, 'langset' => 'zh-cn'],
            'cn' => ['value' => self::LANGUAGE_CN, 'langset' => 'zh-cn'],
            '2' => ['value' => self::LANGUAGE_EN, 'langset' => 'en'],
            'en' => ['value' => self::LANGUAGE_EN, 'langset' => 'en'],
            'en_us' => ['value' => self::LANGUAGE_EN, 'langset' => 'en'],
            'en-us' => ['value' => self::LANGUAGE_EN, 'langset' => 'en'],
        ];

        return isset($map[$language]) ? $map[$language] : null;
    }

    /**
     * 获取语言名称。
     */
    protected function getLanguageName($language)
    {
        return (int)$language === self::LANGUAGE_EN ? __('miniapp.lang_name_en') : __('miniapp.lang_name_cn');
    }

    /**
     * 应用订单状态筛选。
     */
    protected function applyOrderStatusFilter($query, $status)
    {
        if ((int)$status === self::ORDER_STATUS_PENDING) {
            $query->where('status', self::ORDER_STATUS_PENDING);
        } elseif ((int)$status === self::ORDER_STATUS_COMPLETED) {
            $query->where('status', self::ORDER_STATUS_COMPLETED);
        }

        return $query;
    }

    /**
     * 补充订单状态名称，便于前端直接展示。
     */
    protected function formatOrderRows(array $rows)
    {
        foreach ($rows as &$row) {
            $row['status'] = isset($row['status']) ? (int)$row['status'] : 0;
            $row['status_name'] = $this->getOrderStatusName($row['status']);
        }

        return $rows;
    }

    /**
     * 获取订单状态名称。
     */
    protected function getOrderStatusName($status)
    {
        $map = [
            self::ORDER_STATUS_ALL => __('miniapp.order_status_all'),
            self::ORDER_STATUS_PENDING => __('miniapp.order_status_pending'),
            self::ORDER_STATUS_COMPLETED => __('miniapp.order_status_completed'),
        ];

        return isset($map[(int)$status]) ? $map[(int)$status] : __('miniapp.order_status_unknown');
    }

    /**
     * 计算 token 过期时间戳。
     */
    protected function getTokenExpireAt($loginTime)
    {
        return (int)$loginTime + self::TOKEN_EXPIRE_SECONDS;
    }

    /**
     * 判断 token 是否过期。
     */
    protected function isTokenExpired($user)
    {
        $lastLoginTime = isset($user['last_login_time']) ? (int)$user['last_login_time'] : 0;
        if ($lastLoginTime <= 0) {
            return true;
        }

        return $this->getTokenExpireAt($lastLoginTime) <= time();
    }
}
