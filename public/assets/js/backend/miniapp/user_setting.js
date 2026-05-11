define(["jquery", "bootstrap", "backend", "table", "form"], function (
  $,
  undefined,
  Backend,
  Table,
  Form,
) {
  var Controller = {
    index: function () {
      Table.api.init({
        extend: {
          index_url: "miniapp/user_setting/index",
          edit_url: "miniapp/user_setting/edit",
          table: "miniapp_user",
        },
      });

      var table = $("#table");
      if (parseInt(Config.isMiniappAgent || 0, 10) === 1) {
        $(".btn-create-subordinate").removeClass("hidden");
      }

      table.bootstrapTable({
        url: $.fn.bootstrapTable.defaults.extend.index_url,
        pk: "id",
        sortName: "id",
        fixedColumns: true,
        fixedRightNumber: 1,
        columns: [
          [
            { field: "id", title: __("Id"), sortable: true },
            { field: "tel", title: __("Tel"), operate: "LIKE" },
            {
              field: "parent_account",
              title: __("Parent_account"),
              operate: false,
            },
            { field: "username", title: __("Username"), operate: "LIKE" },
            { field: "nickname", title: __("Nickname"), operate: "LIKE" },
            { field: "invite_code", title: __("Invite_code"), operate: "LIKE" },
            { field: "balance", title: __("Balance"), operate: "BETWEEN" },
            {
              field: "dispatch_mode_name",
              title: __("Dispatch_mode"),
              operate: false,
            },
            {
              field: "withdraw_address",
              title: __("Withdraw_address"),
              operate: false,
            },
            {
              field: "show_td",
              title: __("Agent_enabled"),
              searchList: { 1: __("Enabled"), 0: __("Disabled") },
              formatter: function (value) {
                if (parseInt(value, 10) === 1) {
                  return (
                    '<span class="label label-success">' +
                    __("Enabled") +
                    "</span>"
                  );
                }
                return (
                  '<span class="label label-default">' +
                  __("Disabled") +
                  "</span>"
                );
              },
            },
            {
              field: "last_login_time",
              title: __("Last_login_time"),
              operate: "RANGE",
              addclass: "datetimerange",
              formatter: Table.api.formatter.datetime,
            },
            {
              field: "status",
              title: __("Status"),
              searchList: Config.statusList,
              formatter: function (value) {
                if (parseInt(value, 10) === 1) {
                  return (
                    '<span class="label label-success">' +
                    __("Normal") +
                    "</span>"
                  );
                }
                return (
                  '<span class="label label-default">' +
                  __("Disabled") +
                  "</span>"
                );
              },
            },
            {
              field: "operate",
              title: __("Operate"),
              table: table,
              events: Table.api.events.operate,
              buttons: [
                {
                  name: "recharge",
                  text: __("Recharge"),
                  title: __("Recharge"),
                  icon: "fa fa-plus",
                  classname: "btn btn-xs btn-primary btn-dialog",
                  url: "miniapp/user_setting/recharge",
                },
                {
                  name: "withdraw",
                  text: __("Withdraw"),
                  title: __("Withdraw"),
                  icon: "fa fa-minus",
                  classname: "btn btn-xs btn-warning btn-dialog",
                  url: "miniapp/user_setting/withdraw",
                },
                {
                  name: "create_subordinate",
                  text: __("Create_subordinate"),
                  title: __("Create_subordinate"),
                  icon: "fa fa-user-plus",
                  classname: "btn btn-xs btn-success btn-dialog",
                  url: "miniapp/user_setting/create_subordinate",
                  visible: function () {
                    return parseInt(Config.isMiniappAgent || 0, 10) !== 1;
                  },
                },
              ],
              formatter: Table.api.formatter.operate,
            },
          ],
        ],
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
    create_subordinate: function () {
      Controller.api.bindevent();
    },
    api: {
      bindevent: function () {
        Form.api.bindevent($("form[role=form]"));
      },
    },
  };

  return Controller;
});
