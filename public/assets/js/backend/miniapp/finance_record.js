define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            Table.api.init({
                extend: {
                    index_url: 'miniapp/finance_record/index',
                    table: 'miniapp_finance_log'
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
                    {
                        field: 'type',
                        title: __('Type'),
                        searchList: Config.typeList,
                        formatter: function (value, row) {
                            return row.type_text || value;
                        }
                    },
                    {field: 'amount', title: __('Amount'), operate: 'BETWEEN', sortable: true},
                    {field: 'balance_after', title: __('Balance_after'), operate: 'BETWEEN', sortable: true},
                    {field: 'related_order_no', title: __('Related_order_no'), operate: 'LIKE'},
                    {field: 'remark', title: __('Remark'), operate: 'LIKE'},
                    {
                        field: 'status',
                        title: __('Status'),
                        searchList: Config.statusList,
                        formatter: Table.api.formatter.normal
                    },
                    {field: 'create_time', title: __('Create_time'), operate: 'RANGE', addclass: 'datetimerange', formatter: Table.api.formatter.datetime, sortable: true}
                ]]
            });

            Table.api.bindevent(table);
        }
    };

    return Controller;
});
