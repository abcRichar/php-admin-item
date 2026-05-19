<?php

namespace app\api\controller\miniapp;

use think\Db;
use think\Lang;

class Support extends MiniappBase
{
  /**
   * 获取客服/全局支持信息。
   */
  public function index()
  {
    $this->execute(function () {
      $user = $this->getMiniappUser();
      $language = $this->getLanguageValue();
      $rows = Db::name('miniapp_support')
        ->where('status', 1)
        ->where('language', 'in', $this->getLanguageAliases($language))
        ->order('sort desc,id desc')
        ->select();
      if (!$rows && $language !== self::LANGUAGE_CN) {
        $rows = Db::name('miniapp_support')
          ->where('status', 1)
          ->where('language', 'in', $this->getLanguageAliases(self::LANGUAGE_CN))
          ->order('sort desc,id desc')
          ->select();
      }
      $first = $rows ? $rows[0] : null;
      $resolvedLanguage = $first ? (int)($this->normalizeLanguage($first['language'])['value'] ?? $language) : $language;
      $customerServiceLink = (string)Db::name('miniapp_system_config')
        ->where('id', 1)
        ->value('customer_service_link');

      $this->logRequest((int)$user['id']);
      $this->apiSuccess(__('miniapp.success'), [
        'language'              => $resolvedLanguage,
        'language_name'         => $this->getLanguageName($resolvedLanguage),
        'customer_service_link' => $customerServiceLink,
        'contact'               => $first ? [
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

      $user = $this->getMiniappUser();
      Db::name('miniapp_support_language_log')->insert([
        'user_id'     => (int)$user['id'],
        'language'    => $languageConfig['value'],
        'token'       => $this->getToken(),
        'create_time' => time(),
      ]);

      $this->logRequest((int)$user['id']);
      $this->apiSuccess(__('miniapp.success'), [
        'language'      => $languageConfig['value'],
        'language_name' => $this->getLanguageName($languageConfig['value']),
      ]);
    });
  }
}
