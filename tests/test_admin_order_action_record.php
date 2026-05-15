<?php

/**
 * Admin order action record regression checks.
 *
 * The page joins order action logs with users. Search and sort fields must be
 * qualified, otherwise create_time/id/status filters can hit ambiguous columns.
 */

$root = dirname(__DIR__);
$controller = file_get_contents($root . '/application/admin/controller/miniapp/OrderActionRecord.php');
$script = file_get_contents($root . '/public/assets/js/backend/miniapp/order_action_record.js');

function assert_contains($content, $needle, $message)
{
    if (strpos($content, $needle) === false) {
        fwrite(STDERR, "[FAIL] {$message}\n");
        exit(1);
    }
    echo "[OK] {$message}\n";
}

assert_contains(
    $controller,
    '$where = $this->normalizeQueryFields($where);',
    'List search filters are normalized before query'
);

assert_contains(
    $controller,
    '$createTimeRange = $this->extractIntegerTimeRange($where, \'record.create_time\');',
    'Create time range filters are extracted before query'
);

assert_contains(
    $controller,
    '$sort = $this->normalizeSortField($sort);',
    'List sort field is normalized before query'
);

assert_contains(
    $controller,
    "return 'record.' . \$field;",
    'Order action log fields use record alias'
);

assert_contains(
    $controller,
    "return 'user.' . \$field;",
    'User search fields use user alias'
);

assert_contains(
    $controller,
    "\$query->where('record.create_time', '>=', \$createTimeRange['start']);",
    'Create time start condition is applied with integer timestamp'
);

assert_contains(
    $controller,
    "\$query->where('record.create_time', '<=', \$createTimeRange['end']);",
    'Create time end condition is applied with integer timestamp'
);

assert_contains(
    $script,
    "field: 'record.create_time'",
    'Frontend sends qualified create_time field'
);

echo "All admin order action record checks passed.\n";
