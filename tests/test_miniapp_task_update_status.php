<?php

/**
 * Miniapp task update switch regression checks.
 *
 * This is a lightweight static test for the 2026-05-18-2 change:
 * - task_update_status is now the manual task switch
 * - reaching the task limit must not close the task switch
 * - manual reset uses task_reset_time and does not change the switch
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

$rotOrder = file_get_contents($root . '/application/api/controller/miniapp/RotOrder.php');
$order = file_get_contents($root . '/application/api/controller/miniapp/Order.php');
$miniappBase = file_get_contents($root . '/application/api/controller/miniapp/MiniappBase.php');
$userSetting = file_get_contents($root . '/application/admin/controller/miniapp/UserSetting.php');
$editView = file_get_contents($root . '/application/admin/view/miniapp/user_setting/edit.html');
$sql = file_get_contents($root . '/database/sql/20260518_requirement_518_2.sql');

assert_contains(
    $sql,
    'ADD COLUMN `task_reset_time`',
    'SQL adds task_reset_time column'
);

assert_contains(
    $sql,
    '任务开关:0=禁止抢单,1=允许抢单',
    'SQL updates task switch semantics'
);

assert_contains(
    $userSetting,
    "'status'",
    'Backend edit allows saving login status'
);

assert_contains(
    $userSetting,
    'reset_task_count',
    'Backend exposes manual reset action'
);

assert_contains(
    $userSetting,
    "'task_reset_time'",
    'Manual reset only updates task reset time'
);

assert_contains(
    $editView,
    'name="row[status]"',
    'Backend edit form includes login status switch'
);

assert_contains(
    $editView,
    'name="row[task_update_status]"',
    'Backend edit form includes task switch'
);

assert_contains(
    $editView,
    'reset_task_count',
    'Backend edit form includes manual reset button'
);

assert_contains(
    $miniappBase,
    'protected function countCompletedTasks($user)',
    'Completed task count is based on manual reset time'
);

assert_contains(
    $rotOrder,
    'assertTaskUpdateEnabled($user)',
    'New task generation checks task switch'
);

assert_contains(
    $rotOrder,
    '$taskLimitReached = $completedCount >= $orderNum;',
    'Order info detects task limit before returning goods'
);

assert_contains(
    $rotOrder,
    '$canReturnGoods = $taskEnabled && !$taskLimitReached;',
    'Order info returns normal data without goods when task switch is disabled'
);

assert_contains(
    $rotOrder,
    '$message = __(\'miniapp.task_limit_reached\');',
    'Order info returns dedicated message when task limit is reached'
);

assert_contains(
    $rotOrder,
    '$currentGoods = $canReturnGoods ? $this->findRandomActiveGoods($lastCompletedGoodsId) : null;',
    'Order info does not return new goods when task limit is reached'
);

assert_contains(
    $rotOrder,
    "apiBusinessError(__('miniapp.task_update_disabled')",
    'Disabled task update returns dedicated business error message'
);

assert_contains(
    $rotOrder,
    'assertTaskLimitNotReached($completedCount, $orderNum)',
    'Submit order blocks when task limit is reached'
);

assert_not_contains(
    $rotOrder,
    'closeTaskUpdateStatus',
    'Task limit no longer closes task switch'
);

assert_not_contains(
    $order,
    'task_update_status',
    'Completing an order no longer closes task switch'
);

assert_contains(
    $miniappBase,
    "['statuscode' => 200]",
    'Business errors keep HTTP status 200'
);

echo "All miniapp task update switch checks passed.\n";
