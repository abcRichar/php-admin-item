define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            Table.api.init({
                extend: {
                    index_url: 'miniapp/user_setting/index',
                    edit_url: 'miniapp/user_setting/edit',
                    table: 'miniapp_user'
                }
            });

            var table = $('#table');

            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                fixedColumns: true,
                fixedRightNumber: 1,
                columns: [[
                    {field: 'id', title: __('Id'), sortable: true},
                    {field: 'tel', title: __('Tel'), operate: 'LIKE'},
                    {field: 'username', title: __('Username'), operate: 'LIKE'},
                    {field: 'nickname', title: __('Nickname'), operate: 'LIKE'},
                    {field: 'invite_code', title: __('Invite_code'), operate: 'LIKE'},
                    {field: 'balance', title: __('Balance'), operate: 'BETWEEN'},
                    {field: 'template_name', title: __('Template_name'), operate: 'LIKE'},
                    {field: 'dispatch_order', title: __('Dispatch_order'), operate: false},
                    {field: 'commission_rate', title: __('Commission_rate'), operate: false},
                    {field: 'fixed_commission', title: __('Fixed_commission'), operate: false},
                    {field: 'dispatch_amount', title: __('Dispatch_amount'), operate: false},
                    {field: 'last_login_time', title: __('Last_login_time'), operate: 'RANGE', addclass: 'datetimerange', formatter: Table.api.formatter.datetime},
                    {
                        field: 'status',
                        title: __('Status'),
                        searchList: Config.statusList,
                        formatter: function (value) {
                            if (parseInt(value, 10) === 1) {
                                return '<span class="label label-success">' + __('Normal') + '</span>';
                            }
                            return '<span class="label label-default">' + __('Disabled') + '</span>';
                            }
                    },
                    {
                        field: 'operate',
                        title: __('Operate'),
                        table: table,
                        events: Table.api.events.operate,
                        buttons: [
                            {
                                name: 'recharge',
                                text: __('Recharge'),
                                title: __('Recharge'),
                                icon: 'fa fa-plus',
                                classname: 'btn btn-xs btn-primary btn-dialog',
                                url: 'miniapp/user_setting/recharge'
                            },
                            {
                                name: 'withdraw',
                                text: __('Withdraw'),
                                title: __('Withdraw'),
                                icon: 'fa fa-minus',
                                classname: 'btn btn-xs btn-warning btn-dialog',
                                url: 'miniapp/user_setting/withdraw'
                            }
                        ],
                        formatter: Table.api.formatter.operate
                    }
                ]]
            });

            Table.api.bindevent(table);
        },
        edit: function () {
            Controller.api.bindevent();
        },
        recharge: function () {
            Controller.api.bindevent();
        },
        withdraw: function () {
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
