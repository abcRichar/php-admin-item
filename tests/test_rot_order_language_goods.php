<?php

/**
 * Rot order language regression checks.
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
    'protected function findActiveGoodsByLanguage($language)',
    'Rot order queries goods through language-aware helper'
);

assert_file_contains(
    $rotOrder,
    "->where('language', 'in', \$this->getLanguageAliases(\$language))",
    'Rot order goods/config queries support legacy language values'
);

assert_file_contains(
    $rotOrder,
    'protected function refreshPreviewOrderLanguage($user, $undoneOrder, $goods, $language)',
    'Rot order can refresh unsubmitted preview order language'
);

assert_file_contains(
    $rotOrder,
    '$currentGoods = $this->findActiveGoodsByLanguage(self::LANGUAGE_EN);',
    'Order info always returns English goods'
);

assert_file_contains(
    $rotOrder,
    '$undoneOrder = $this->refreshPreviewOrderLanguage($user, $undoneOrder, $currentGoods, $language);',
    'Order info refreshes status 0 preview orders after language switch'
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
