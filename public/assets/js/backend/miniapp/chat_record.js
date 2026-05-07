define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            function escapeHtml(text) {
                return $('<div/>').text(text || '').html();
            }

            Table.api.init({
                extend: {
                    index_url: 'miniapp/chat_record/index',
                    table: 'miniapp_chat_message'
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
                    {
                        field: 'record.room_id',
                        title: __('Room_id'),
                        searchList: Config.roomList,
                        formatter: function (value, row) {
                            return row.room_name || (Config.roomList && Config.roomList[row.room_id]) || row.room_id;
                        }
                    },
                    {
                        field: 'record.sender_type',
                        title: __('Sender_type'),
                        searchList: Config.senderTypeList,
                        formatter: function (value, row) {
                            return row.sender_type_text || row.sender_type;
                        }
                    },
                    {field: 'sender_display_name', title: __('Sender_display_name'), operate: false},
                    {
                        field: 'record.message_type',
                        title: __('Message_type'),
                        searchList: Config.messageTypeList,
                        formatter: function (value, row) {
                            return row.message_type_text || row.message_type;
                        }
                    },
                    {
                        field: 'record.content',
                        title: __('Content'),
                        operate: 'LIKE',
                        width: 380,
                        formatter: function (value, row) {
                            var text = row.content || '';
                            var shortText = text.length > 80 ? text.substr(0, 80) + '...' : text;
                            return '<span class="chat-record-content" title="' + escapeHtml(text) + '">' +
                                escapeHtml(shortText) + '</span>';
                        }
                    },
                    {field: 'record.client_ip', title: __('Client_ip'), operate: 'LIKE', formatter: function (value, row) {
                        return row.client_ip;
                    }},
                    {
                        field: 'record.status',
                        title: __('Status'),
                        searchList: Config.statusList,
                        formatter: function (value, row) {
                            return row.status_text || row.status;
                        }
                    },
                    {field: 'record.create_time', title: __('Create_time'), operate: 'RANGE', addclass: 'datetimerange', sortable: true, formatter: function (value, row) {
                        return row.create_time_text || Table.api.formatter.datetime(row.create_time);
                    }}
                ]]
            });

            Table.api.bindevent(table);
        }
    };

    return Controller;
});
