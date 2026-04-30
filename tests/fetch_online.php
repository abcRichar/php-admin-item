<?php

/**
 * 批量获取线上接口返回，只输出 key 结构
 */
$token = '8174670908a97aa7de24f6340f906f91';
$base = 'https://back.aliexpressplus.top';

$apis = [
  ['GET',  '/index/index/homeNew', []],
  ['POST', '/index/order/orderRecord', ['page' => 1, 'size' => 10, 'status' => 1]],
  ['POST', '/index/order/orderRecord', ['page' => 1, 'size' => 10, 'status' => -1]],
  ['GET',  '/index/rot_order/orderInfo', []],
  ['POST', '/index/rot_order/submit_order', []],
  ['POST', '/index/order/order_info', ['id' => 'UB2604221943197198']],
  ['POST', '/index/order/do_order', ['oid' => 'UB2604221943197198']],
  ['POST', '/index/ctrl/teamAll', []],
  ['GET',  '/index/my/indexNew', []],
  ['POST', '/index/ctrl/do_withdraw', ['num' => 1, 'type' => 'bank', 'paypassword' => 1]],
  ['GET',  '/index/ctrl/rechargeNew', []],
  ['GET',  '/index/my/userInfo', []],
  ['POST', '/index/my/uinfoSave', ['pwd' => 1, 'pwd_new' => 1]],
  ['POST', '/index/my/caiwu', ['page' => 1, 'size' => 10, 'type' => 9]],
  ['POST', '/index/my/caiwu', ['page' => 1, 'size' => 10, 'type' => 1]],
  ['POST', '/index/my/caiwu', ['page' => 1, 'size' => 10, 'type' => 7]],
];

function showKeys($data, $prefix = '')
{
  if (is_array($data) || is_object($data)) {
    foreach ((array)$data as $k => $v) {
      $path = $prefix ? "$prefix.$k" : $k;
      if (is_array($v) && !empty($v) && isset($v[0])) {
        echo "  $path: array[" . count($v) . "]\n";
        showKeys($v[0], "$path.[]");
      } elseif (is_array($v) || is_object($v)) {
        echo "  $path: object\n";
        showKeys($v, $path);
      } else {
        echo "  $path: " . json_encode($v) . "\n";
      }
    }
  }
}

foreach ($apis as $api) {
  list($method, $path, $params) = $api;
  $url = $base . $path;
  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, $url);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($ch, CURLOPT_HTTPHEADER, [
    'accept: */*',
    'content-type: application/x-www-form-urlencoded',
    'language: zh_cn',
    "token: $token",
  ]);
  curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
  curl_setopt($ch, CURLOPT_TIMEOUT, 15);
  if ($method === 'POST') {
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($params));
  }
  $resp = curl_exec($ch);
  $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  curl_close($ch);

  $paramStr = $params ? '(' . http_build_query($params) . ')' : '';
  echo "\n=== $method $path $paramStr ===\n";
  echo "HTTP: $httpCode\n";
  $json = json_decode($resp, true);
  if ($json) {
    showKeys($json);
  } else {
    echo "RAW: " . substr($resp, 0, 200) . "\n";
  }
}
