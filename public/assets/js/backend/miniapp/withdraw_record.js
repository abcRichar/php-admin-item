define(['jquery', 'bootstrap', 'backend', 'table', 'form', 'layer'], function ($, undefined, Backend, Table, Form, Layer) {

    var Controller = {
        index: function () {
            Table.api.init({
                extend: {
                    index_url: 'miniapp/withdraw_record/index',
                    approve_url: 'miniapp/withdraw_record/approve',
                    reject_url: 'miniapp/withdraw_record/reject',
                    table: 'miniapp_withdraw'
                }
            });

            var table = $('#table');

            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'record.id',
                columns: [[
                    {field: 'id', title: __('Id'), sortable: true},
                    {field: 'user_id', title: __('User_id'), operate: '='},
                    {field: 'display_name', title: __('Display_name'), operate: false},
                    {field: 'withdraw_no', title: __('Withdraw_no'), operate: 'LIKE'},
                    {field: 'type', title: __('Type'), operate: 'LIKE'},
                    {field: 'withdraw_address', title: __('Withdraw_address'), operate: 'LIKE'},
                    {field: 'amount', title: __('Amount'), operate: 'BETWEEN', sortable: true},
                    {
                        field: 'status',
                        title: __('Status'),
                        searchList: Config.statusList,
                        formatter: function (value, row) {
                            if (parseInt(value, 10) === 1) {
                                return '<span class="label label-success">' + __('Approved') + '</span>';
                            }
                            if (parseInt(value, 10) === 2) {
                                return '<span class="label label-danger">' + __('Rejected') + '</span>';
                            }
                            return '<span class="label label-warning">' + __('Pending') + '</span>';
                        }
                    },
                    {field: 'create_time', title: __('Create_time'), operate: 'RANGE', addclass: 'datetimerange', formatter: Table.api.formatter.datetime, sortable: true},
                    {field: 'update_time', title: __('Update_time'), operate: 'RANGE', addclass: 'datetimerange', formatter: Table.api.formatter.datetime, sortable: true},
                    {
                        field: 'operate',
                        title: __('Operate'),
                        table: table,
                        events: Table.api.events.operate,
                        formatter: function (value, row, index) {
                            if (parseInt(row.status, 10) !== 0) {
                                return '<span class="text-muted">' + __('Audited') + '</span>';
                            }
                            if (parseInt(row.can_audit || 0, 10) !== 1) {
                                return '<span class="text-muted">--</span>';
                            }
                            return [
                                '<a href="javascript:;" class="btn btn-xs btn-success btn-audit-action" data-url="' + Backend.api.fixurl($.fn.bootstrapTable.defaults.extend.approve_url + '/ids/' + row.id) + '" data-confirm="' + __('Confirm approve withdraw') + '"><i class="fa fa-check"></i> ' + __('Approve') + '</a>',
                                '<a href="javascript:;" class="btn btn-xs btn-danger btn-audit-action" data-url="' + Backend.api.fixurl($.fn.bootstrapTable.defaults.extend.reject_url + '/ids/' + row.id) + '" data-confirm="' + __('Confirm reject withdraw') + '"><i class="fa fa-times"></i> ' + __('Reject') + '</a>'
                            ].join(' ');
                        }
                    }
                ]]
            });

            Table.api.bindevent(table);
            table.off('click', '.btn-audit-action').on('click', '.btn-audit-action', function (e) {
                e.preventDefault();
                var url = $(this).data('url');
                var confirm = $(this).data('confirm');
                var submit = function () {
                    Backend.api.ajax({url: url}, function () {
                        table.bootstrapTable('refresh');
                    });
                };

                if (confirm) {
                    Layer.confirm(confirm, function (index) {
                        submit();
                        Layer.close(index);
                    });
                } else {
                    submit();
                }
                return false;
            });
        }
    };

    return Controller;
});
