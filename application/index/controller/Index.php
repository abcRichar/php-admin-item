<?php

namespace app\index\controller;

use app\common\model\MiniappHome;
use app\common\model\MiniappHomeRequestLog;
use app\common\controller\Frontend;

class Index extends Frontend
{

    protected $noNeedLogin = '*';
    protected $noNeedRight = '*';
    protected $layout = '';

    public function index()
    {
        return $this->view->fetch();
    }

    public function homeNew()
    {
        if (!$this->request->isGet() && !$this->request->isPost()) {
            return json([
                'code' => 0,
                'msg'  => 'Method not allowed',
                'data' => null,
            ], 405);
        }

        $language = (string)$this->request->header('language', $this->request->param('language', 'zh_cn'));
        $token = (string)$this->request->header('token', $this->request->param('token', ''));

        $home = MiniappHome::getActiveHome($language);
        if (!$home) {
            return json([
                'code' => 0,
                'msg'  => 'Home data not configured',
                'data' => null,
            ], 404);
        }

        $this->writeHomeNewRequestLog($home->id, $language);

        return json([
            'code' => 1,
            'msg'  => 'success',
            'data' => [
                'id'             => (int)$home->id,
                'name'           => (string)$home->name,
                'language'       => $language,
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
            ],
        ]);
    }

    protected function writeHomeNewRequestLog($homeId, $language)
    {
        try {
            $requestLog = new MiniappHomeRequestLog();
            $requestLog->allowField(true)->save([
                'home_id'            => $homeId ?: null,
                'language'           => $language,
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
                'token'              => (string)$this->request->header('token', ''),
                'user_agent'         => (string)$this->request->header('user-agent', ''),
                'client_ip'          => (string)$this->request->ip(),
                'request_method'     => (string)$this->request->method(),
                'request_uri'        => (string)$this->request->url(),
                'payload'            => json_encode($this->request->param(), JSON_UNESCAPED_UNICODE),
            ]);
        } catch (\Throwable $e) {
        }
    }

}
