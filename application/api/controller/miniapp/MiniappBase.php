<?php

namespace app\api\controller\miniapp;

use app\common\controller\Api;
use think\Db;
use think\exception\HttpResponseException;
use think\Lang;

/**
 * Miniapp 模块基类，提供公共常量、初始化、鉴权、语言、日志等能力。
 * 所有 miniapp 子控制器继承此类即可。
 */
class MiniappBase extends Api
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

  protected function _initialize()
  {
    $this->miniappLanguage = $this->resolveLanguageConfig(true);
    parent::_initialize();
    Lang::range($this->miniappLanguage['langset']);
    Lang::load(APP_PATH . 'api/lang/' . $this->miniappLanguage['langset'] . '/miniapp.php');
  }

  // ==================== 响应 ====================

  protected function apiSuccess($msg = '', $data = null)
  {
    $this->success($msg, $data, 200, null, ['statuscode' => 200]);
  }

  protected function apiError($msg = '', $data = null, $statusCode = 400)
  {
    $this->error($msg, $data, $statusCode, null, ['statuscode' => $statusCode]);
  }

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

  // ==================== Token / 用户 ====================

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

  protected function getTokenExpireAt($loginTime)
  {
    return (int)$loginTime + self::TOKEN_EXPIRE_SECONDS;
  }

  protected function isTokenExpired($user)
  {
    $lastLoginTime = isset($user['last_login_time']) ? (int)$user['last_login_time'] : 0;
    if ($lastLoginTime <= 0) {
      return true;
    }
    return $this->getTokenExpireAt($lastLoginTime) <= time();
  }

  // ==================== 语言 ====================

  protected function getLanguageValue()
  {
    if (!$this->miniappLanguage) {
      $this->miniappLanguage = $this->resolveLanguageConfig(true);
    }
    return (int)$this->miniappLanguage['value'];
  }

  protected function getLanguageName($language)
  {
    return (int)$language === self::LANGUAGE_EN ? __('miniapp.lang_name_en') : __('miniapp.lang_name_cn');
  }

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

  protected function normalizeLanguage($language)
  {
    $language = strtolower(trim((string)$language));
    $map = [
      '1'     => ['value' => self::LANGUAGE_CN, 'langset' => 'zh-cn'],
      'zh_cn' => ['value' => self::LANGUAGE_CN, 'langset' => 'zh-cn'],
      'zh-cn' => ['value' => self::LANGUAGE_CN, 'langset' => 'zh-cn'],
      'zh'    => ['value' => self::LANGUAGE_CN, 'langset' => 'zh-cn'],
      'cn'    => ['value' => self::LANGUAGE_CN, 'langset' => 'zh-cn'],
      '2'     => ['value' => self::LANGUAGE_EN, 'langset' => 'en'],
      'en'    => ['value' => self::LANGUAGE_EN, 'langset' => 'en'],
      'en_us' => ['value' => self::LANGUAGE_EN, 'langset' => 'en'],
      'en-us' => ['value' => self::LANGUAGE_EN, 'langset' => 'en'],
    ];
    return isset($map[$language]) ? $map[$language] : null;
  }

  // ==================== 日志 ====================

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
}
