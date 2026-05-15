define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            Table.api.init({
                extend: {
                    index_url: 'miniapp/order_action_record/index',
                    table: 'miniapp_order_action_log'
                }
            });

            var table = $('#table');

            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'record.id',
                columns: [[
                    {field: 'record.id', title: __('Id'), sortable: true, formatter: function (value, row) {
                        return row.id;
                    }},
                    {field: 'record.user_id', title: __('User_id'), operate: '=', formatter: function (value, row) {
                        return row.user_id;
                    }},
                    {field: 'display_name', title: __('Display_name'), operate: false},
                    {field: 'record.order_id', title: __('Order_id'), operate: '=', formatter: function (value, row) {
                        return row.order_id;
                    }},
                    {field: 'record.order_no', title: __('Order_no'), operate: 'LIKE', formatter: function (value, row) {
                        return row.order_no;
                    }},
                    {
                        field: 'record.action',
                        title: __('Action'),
                        searchList: Config.actionList,
                        formatter: function (value, row) {
                            return row.action_text || value;
                        }
                    },
                    {field: 'record.amount', title: __('Amount'), operate: 'BETWEEN', sortable: true, formatter: function (value, row) {
                        return row.amount;
                    }},
                    {
                        field: 'record.status',
                        title: __('Status'),
                        searchList: Config.statusList,
                        formatter: Table.api.formatter.normal
                    },
                    {field: 'record.create_time', title: __('Create_time'), operate: 'RANGE', addclass: 'datetimerange', formatter: function (value, row) {
                        return row.create_time_text || Table.api.formatter.datetime(row.create_time);
                    }, sortable: true}
                ]]
            });

            Table.api.bindevent(table);
        }
    };

    return Controller;
});
