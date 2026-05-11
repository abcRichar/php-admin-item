define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            Table.api.init({
                extend: {
                    index_url: 'miniapp/goods/index',
                    add_url: 'miniapp/goods/add',
                    edit_url: 'miniapp/goods/edit',
                    del_url: 'miniapp/goods/del',
                    multi_url: 'miniapp/goods/multi',
                    table: 'miniapp_goods'
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
                    {field: 'language', title: __('Language'), searchList: Config.languageList, formatter: function (value, row) {
                        return row.language_text || value;
                    }},
                    {field: 'title', title: __('Title'), operate: 'LIKE'},
                    {field: 'sub_title', title: __('Sub_title'), operate: 'LIKE'},
                    {field: 'image', title: __('Image'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
                    {field: 'price', title: __('Price'), operate: 'BETWEEN', sortable: true},
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
