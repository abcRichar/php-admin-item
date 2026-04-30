define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            Table.api.init({
                extend: {
                    index_url: 'miniapp/withdraw_record/index',
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
                    {field: 'amount', title: __('Amount'), operate: 'BETWEEN', sortable: true},
                    {
                        field: 'status',
                        title: __('Status'),
                        searchList: Config.statusList,
                        formatter: Table.api.formatter.normal
                    },
                    {field: 'create_time', title: __('Create_time'), operate: 'RANGE', addclass: 'datetimerange', formatter: Table.api.formatter.datetime, sortable: true},
                    {field: 'update_time', title: __('Update_time'), operate: 'RANGE', addclass: 'datetimerange', formatter: Table.api.formatter.datetime, sortable: true}
                ]]
            });

            Table.api.bindevent(table);
        }
    };

    return Controller;
});
