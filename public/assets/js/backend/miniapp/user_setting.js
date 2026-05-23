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
          reset_task_count_url: "miniapp/user_setting/reset_task_count",
          table: "miniapp_user",
        },
      });

      var table = $("#table");
      table.data("operate-create_subordinate", true);
      var createSubordinateButton = function (row, index) {
        var url = Fast.api.fixurl(
          Table.api.replaceurl(
            "miniapp/user_setting/create_subordinate",
            row,
            table,
          ),
        );
        return (
          '<a href="' +
          url +
          '" class="btn btn-xs btn-success btn-dialog" title="' +
          __("Create_subordinate") +
          '" data-table-id="table" data-row-index="' +
          index +
          '"><i class="fa fa-user-plus"></i> ' +
          __("Create_subordinate") +
          "</a>"
        );
      };
      if (parseInt(Config.canCreateSubordinate || 0, 10) === 1) {
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
              field: "current_difference_amount",
              title: __("Difference_amount"),
              operate: false,
            },
            {
              field: "withdraw_address",
              title: __("Withdraw_address"),
              operate: false,
            },
            {
              field: "task_progress",
              title: __("Task_progress"),
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
              field: "task_update_status",
              title: __("Task_status"),
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
                  name: "reset_task_count",
                  text: __("Reset_task_count"),
                  title: __("Reset_task_count"),
                  icon: "fa fa-refresh",
                  classname: "btn btn-xs btn-danger btn-ajax",
                  url: $.fn.bootstrapTable.defaults.extend.reset_task_count_url,
                  confirm: __("Confirm reset task count"),
                  success: function () {
                    table.bootstrapTable("refresh");
                  },
                },
                {
                  name: "create_subordinate_placeholder",
                  hidden: true,
                },
              ],
              formatter: function (value, row, index) {
                var html = Table.api.formatter.operate.call(
                  this,
                  value,
                  row,
                  index,
                );
                return html + " " + createSubordinateButton(row, index);
              },
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
