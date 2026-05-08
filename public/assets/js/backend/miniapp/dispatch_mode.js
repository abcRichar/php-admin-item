define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            Table.api.init({
                extend: {
                    index_url: 'miniapp/dispatch_mode/index',
                    add_url: 'miniapp/dispatch_mode/add',
                    edit_url: 'miniapp/dispatch_mode/edit',
                    del_url: 'miniapp/dispatch_mode/del',
                    multi_url: 'miniapp/dispatch_mode/multi',
                    table: 'miniapp_dispatch_mode'
                }
            });

            var table = $('#table');

            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'sort',
                columns: [[
                    {checkbox: true},
                    {field: 'id', title: __('Id'), sortable: true},
                    {field: 'template_name', title: __('Template_name'), operate: 'LIKE'},
                    {field: 'dispatch_order', title: __('Dispatch_order'), operate: false},
                    {field: 'commission_rate', title: __('Commission_rate'), operate: false},
                    {field: 'fixed_commission', title: __('Fixed_commission'), operate: false},
                    {field: 'dispatch_amount', title: __('Dispatch_amount'), operate: false},
                    {field: 'sort', title: __('Sort'), operate: 'BETWEEN', sortable: true},
                    {field: 'status', title: __('Status'), searchList: Config.statusList, formatter: Table.api.formatter.normal},
                    {field: 'update_time', title: __('Update_time'), operate: 'RANGE', addclass: 'datetimerange', formatter: Table.api.formatter.datetime, sortable: true},
                    {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                ]]
            });

            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($('form[role=form]'));
            }
        }
    };

    return Controller;
});
