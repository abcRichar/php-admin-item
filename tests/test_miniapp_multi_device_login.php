<?php

/**
 * Miniapp multi-device login regression checks.
 */

$root = dirname(__DIR__);

function assert_contains($content, $needle, $message)
{
    if (strpos($content, $needle) === false) {
        fwrite(STDERR, "[FAIL] {$message}\n");
        exit(1);
    }
    echo "[OK] {$message}\n";
}

function assert_not_contains($content, $needle, $message)
{
    if (strpos($content, $needle) !== false) {
        fwrite(STDERR, "[FAIL] {$message}\n");
        exit(1);
    }
    echo "[OK] {$message}\n";
}

$base = file_get_contents($root . '/application/api/controller/miniapp/MiniappBase.php');
$user = file_get_contents($root . '/application/api/controller/miniapp/User.php');
$chatServer = file_get_contents($root . '/application/admin/command/MiniappChatServer.php');
$sql = file_get_contents($root . '/database/sql/20260524_add_miniapp_user_token.sql');

assert_contains(
    $sql,
    'CREATE TABLE IF NOT EXISTS `fa_miniapp_user_token`',
    'SQL creates miniapp user token session table'
);

assert_contains(
    $sql,
    'UNIQUE KEY `uk_token` (`token`)',
    'Token session table enforces unique token'
);

assert_contains(
    $base,
    'protected function createMiniappUserToken($user, $token, $now = null)',
    'Miniapp base can create token sessions'
);

assert_contains(
    $base,
    'protected function getMiniappUserByToken($token)',
    'Miniapp base resolves users by token session'
);

assert_contains(
    $base,
    "Db::name('miniapp_user_token')->where('token', \$token)->find()",
    'Miniapp auth checks token session table first'
);

assert_contains(
    $base,
    "Db::name('miniapp_user')->where('token', \$token)->where('status', 1)->find()",
    'Miniapp auth keeps legacy token fallback'
);

assert_contains(
    $user,
    '$this->createMiniappUserToken($user, $token, $now);',
    'Login/register write a token session'
);

assert_contains(
    $user,
    '$this->invalidateMiniappToken($this->getToken(), $now);',
    'Logout invalidates only current token session'
);

assert_not_contains(
    $user,
    "update(['token' => '', 'update_time' => \$now])",
    'Logout no longer clears latest user token and kicks other devices'
);

assert_contains(
    $chatServer,
    '$this->getMiniappUserByToken($token)',
    'WebSocket auth supports multi-device token sessions'
);

echo "All miniapp multi-device login checks passed.\n";
