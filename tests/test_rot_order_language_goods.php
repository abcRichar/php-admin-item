<?php

/**
 * Rot order goods selection regression checks.
 */

$root = dirname(__DIR__);

function assert_file_contains($content, $needle, $message)
{
    if (strpos($content, $needle) === false) {
        fwrite(STDERR, "[FAIL] {$message}\n");
        exit(1);
    }
    echo "[OK] {$message}\n";
}

function assert_file_not_contains($content, $needle, $message)
{
    if (strpos($content, $needle) !== false) {
        fwrite(STDERR, "[FAIL] {$message}\n");
        exit(1);
    }
    echo "[OK] {$message}\n";
}

$base = file_get_contents($root . '/application/api/controller/miniapp/MiniappBase.php');
$rotOrder = file_get_contents($root . '/application/api/controller/miniapp/RotOrder.php');
$support = file_get_contents($root . '/application/api/controller/miniapp/Support.php');
$goodsModel = file_get_contents($root . '/application/admin/model/MiniappGoods.php');

assert_file_contains(
    $base,
    'protected function getLanguageAliases($language)',
    'Miniapp base exposes language aliases'
);

assert_file_contains(
    $base,
    "->whereOr('user_id', (int)\$user['id'])",
    'Language history resolves latest token or account setting'
);

assert_file_contains(
    $rotOrder,
    'protected function findRandomActiveGoods($excludeGoodsId = 0, $maxPrice = 0)',
    'Rot order uses random active goods helper'
);

assert_file_contains(
    $rotOrder,
    'protected function getLastCompletedGoodsId($user)',
    'New orders can avoid repeating the last completed goods'
);

assert_file_not_contains(
    $rotOrder,
    'refreshPreviewOrderGoods',
    'Uncompleted preview orders keep the original goods'
);

assert_file_contains(
    $rotOrder,
    "->orderRaw('RAND()')->find()",
    'Rot order randomly returns one active goods item'
);

assert_file_not_contains(
    $rotOrder,
    'selectActiveGoodsByLanguage',
    'Rot order no longer polls goods by list order'
);

assert_file_not_contains(
    $rotOrder,
    'findActiveGoodsByLanguage',
    'Rot order no longer filters goods by user language'
);

assert_file_contains(
    $rotOrder,
    '$currentGoods = $canReturnGoods ? $this->findDispatchGoods($user, $nextTodayDan, $language, $lastCompletedGoodsId) : null;',
    'Order info returns no goods after task limit is reached'
);

assert_file_contains(
    $support,
    '$user = $this->getMiniappUser();',
    'Support APIs require token user context'
);

assert_file_contains(
    $support,
    "->where('language', 'in', \$this->getLanguageAliases(\$language))",
    'Support index queries contact through current user language aliases'
);

assert_file_contains(
    $goodsModel,
    'public function setLanguageAttr($value)',
    'Admin goods saves canonical language value'
);

echo "All rot order language checks passed.\n";
