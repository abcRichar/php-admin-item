<?php

/**
 * 执行增量SQL - 对齐线上接口字段
 */
define('APP_PATH', __DIR__ . '/../application/');
// 加载 .env
$envFile = __DIR__ . '/../.env';
if (file_exists($envFile)) {
  $lines = file($envFile, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
  $section = '';
  foreach ($lines as $line) {
    $line = trim($line);
    if ($line === '' || $line[0] === '#') continue;
    if (preg_match('/^\[(\w+)\]$/', $line, $m)) {
      $section = strtoupper($m[1]) . '.';
      continue;
    }
    if (strpos($line, '=') !== false) {
      list($k, $v) = explode('=', $line, 2);
      putenv($section . trim($k) . '=' . trim($v));
    }
  }
}
require __DIR__ . '/../thinkphp/base.php';

$dbConfig = [
  'type'     => 'mysql',
  'hostname' => getenv('DATABASE.HOSTNAME') ?: '127.0.0.1',
  'database' => getenv('DATABASE.DATABASE') ?: 'www_fa_com',
  'username' => getenv('DATABASE.USERNAME') ?: 'root',
  'password' => getenv('DATABASE.PASSWORD') ?: '',
  'hostport' => getenv('DATABASE.HOSTPORT') ?: '3306',
  'charset'  => 'utf8mb4',
  'prefix'   => getenv('DATABASE.PREFIX') ?: 'fa_',
];
$db = \think\Db::connect($dbConfig);

$sqlFile = __DIR__ . '/../database/sql/20260423_miniapp_align_online.sql';
$sql = file_get_contents($sqlFile);

// 去掉注释行
$sql = preg_replace('/^--.*$/m', '', $sql);
$sql = preg_replace('/^\s*SET\s+NAMES\s+/mi', 'SET NAMES ', $sql);

// 按分号分割
$statements = array_filter(array_map('trim', explode(';', $sql)));

$success = 0;
$skip = 0;
$errors = [];

foreach ($statements as $stmt) {
  if (empty($stmt) || $stmt === ';') continue;
  try {
    $db->execute($stmt);
    $success++;
    // 提取关键字前30字符
    $preview = substr(preg_replace('/\s+/', ' ', $stmt), 0, 80);
    echo "[OK] $preview...\n";
  } catch (\Throwable $e) {
    $msg = $e->getMessage();
    // 如果是 Duplicate column 或 table already exists 就跳过
    if (strpos($msg, 'Duplicate column') !== false || strpos($msg, 'already exists') !== false) {
      $skip++;
      $preview = substr(preg_replace('/\s+/', ' ', $stmt), 0, 60);
      echo "[SKIP] $preview... (already exists)\n";
    } else {
      $errors[] = $msg;
      $preview = substr(preg_replace('/\s+/', ' ', $stmt), 0, 60);
      echo "[ERR] $preview...\n     $msg\n";
    }
  }
}

echo "\nDone: $success OK, $skip skipped, " . count($errors) . " errors\n";
