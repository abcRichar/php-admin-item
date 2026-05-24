<?php

/**
 * Rot order difference amount regression checks.
 *
 * Existing status=0 preview orders with a configured difference amount must not
 * be recalculated from the user's current balance, otherwise recharging the
 * difference raises the preview amount again and the miniapp keeps showing a gap
 * while backend shows 0.
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

$rotOrder = file_get_contents($root . '/application/api/controller/miniapp/RotOrder.php');
$userSetting = file_get_contents($root . '/application/admin/controller/miniapp/UserSetting.php');

assert_contains(
    $rotOrder,
    'protected function shouldRefreshUndonePreviewOrder($undoneOrder, $user)',
    'Rot order centralizes preview order refresh decision'
);

assert_contains(
    $rotOrder,
    'return $this->getEffectiveOrderDifferenceAmount($undoneOrder, $user) <= 0;',
    'Difference preview orders keep original amount after recharge'
);

assert_contains(
    $rotOrder,
    'if ($this->shouldRefreshUndonePreviewOrder($undoneOrder, $user))',
    'Order info uses difference-safe preview refresh guard'
);

assert_contains(
    $rotOrder,
    '$requiredBalance = round($baseBalance + $differenceAmount, 2);',
    'Miniapp current difference uses order balance snapshot plus difference'
);

assert_contains(
    $userSetting,
    '$requiredBalance = round($baseBalance + $differenceAmount, 2);',
    'Backend current difference uses the same balance snapshot formula'
);

echo "All rot order difference amount checks passed.\n";
