<?php

/**
 * Miniapp task update switch regression checks.
 *
 * This is a lightweight static test for the 2026-05-13 change:
 * - new task generation must check task_update_status
 * - unsubmitted preview orders must also check task_update_status
 * - successful generation must close the switch once
 * - backend setting must persist status and task_update_status
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
$order = file_get_contents($root . '/application/api/controller/miniapp/Order.php');
$miniappBase = file_get_contents($root . '/application/api/controller/miniapp/MiniappBase.php');
$userSetting = file_get_contents($root . '/application/admin/controller/miniapp/UserSetting.php');
$editView = file_get_contents($root . '/application/admin/view/miniapp/user_setting/edit.html');
$sql = file_get_contents($root . '/database/sql/20260513_add_miniapp_user_task_update_status.sql');

assert_contains(
    $sql,
    'ADD COLUMN `task_update_status`',
    'SQL adds task_update_status column'
);

assert_contains(
    $userSetting,
    "'status'",
    'Backend edit allows saving login status'
);

assert_contains(
    $userSetting,
    "'task_update_status'",
    'Backend edit allows saving task update status'
);

assert_contains(
    $editView,
    'name="row[status]"',
    'Backend edit form includes login status switch'
);

assert_contains(
    $editView,
    'name="row[task_update_status]"',
    'Backend edit form includes task update switch'
);

assert_contains(
    $rotOrder,
    'assertTaskUpdateEnabled($user)',
    'New task generation checks task update switch'
);

assert_contains(
    $rotOrder,
    'if ($undoneOrder && (int)$undoneOrder[\'status\'] === 0)',
    'Order info blocks unsubmitted preview order when task update is disabled'
);

assert_contains(
    $rotOrder,
    "'task_update_status' => 0",
    'Successful task submit closes task update switch'
);

assert_contains(
    $rotOrder,
    "apiBusinessError(__('miniapp.task_update_disabled')",
    'Disabled task update returns dedicated business error message'
);

assert_contains(
    $rotOrder,
    'assertDailyTaskCanContinue($user, $completedCount, $orderNum)',
    'Daily completed task limit is checked before creating or submitting next task'
);

assert_contains(
    $rotOrder,
    '$this->closeTaskUpdateStatus((int)$user[\'id\'])',
    'Daily completed task limit blocks even when task update switch was opened'
);

assert_contains(
    $order,
    '$completedAfter >= $this->getDailyOrderNum($language)',
    'Completing the daily task quota closes task update switch'
);

assert_contains(
    $miniappBase,
    "['statuscode' => 200]",
    'Business errors keep HTTP status 200'
);

echo "All miniapp task update switch checks passed.\n";
