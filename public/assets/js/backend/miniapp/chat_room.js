define(['jquery', 'bootstrap', 'backend', 'fast', 'toastr'], function ($, undefined, Backend, Fast, Toastr) {

    var Controller = {
        index: function () {
            var rooms = Config.rooms || [];
            var currentRoom = null;
            var socket = null;
            var connectTimer = null;
            var heartbeatTimer = null;
            var connectingRoomId = 0;
            var connectVersion = 0;
            var firstMessageId = 0;
            var messageIds = {};
            var authed = false;

            function escapeHtml(text) {
                return $('<div/>').text(text || '').html();
            }

            function setStatus(text, online) {
                $('#chat-status')
                    .text(text)
                    .toggleClass('online', !!online)
                    .toggleClass('offline', !online);
            }

            function getRoom(roomId) {
                roomId = parseInt(roomId, 10);
                for (var i = 0; i < rooms.length; i++) {
                    if (parseInt(rooms[i].id, 10) === roomId) {
                        return rooms[i];
                    }
                }
                return null;
            }

            function scrollBottom() {
                var el = $('#chat-messages');
                el.scrollTop(el[0].scrollHeight);
            }

            function renderMessage(message, prepend) {
                if (!message || messageIds[message.id]) {
                    return;
                }
                messageIds[message.id] = true;
                if (!firstMessageId || message.id < firstMessageId) {
                    firstMessageId = message.id;
                }

                var isAdmin = message.sender_type === 'admin';
                var html = [
                    '<div class="chat-msg ' + (isAdmin ? 'admin' : 'user') + '" data-id="' + message.id + '">',
                    '<div class="chat-bubble">',
                    '<div class="chat-meta">' + escapeHtml(message.sender_name) + ' · ' + escapeHtml(message.time_text) + '</div>',
                    '<div class="chat-content">' + escapeHtml(message.content) + '</div>',
                    '</div>',
                    '</div>'
                ].join('');

                if (prepend) {
                    $('#chat-message-list').prepend(html);
                } else {
                    $('#chat-message-list').append(html);
                    scrollBottom();
                }
            }

            function resetMessages() {
                firstMessageId = 0;
                messageIds = {};
                $('#chat-messages').html([
                    '<div class="chat-load-more"><button type="button" class="btn btn-xs btn-default" id="chat-load-more">加载更早消息</button></div>',
                    '<div id="chat-message-list"></div>'
                ].join(''));
            }

            function loadMessages(prepend) {
                if (!currentRoom) {
                    return;
                }
                Fast.api.ajax({
                    url: 'miniapp/chat_room/messages',
                    type: 'GET',
                    loading: false,
                    data: {
                        room_id: currentRoom.id,
                        before_id: prepend ? firstMessageId : 0,
                        limit: 50
                    }
                }, function (data) {
                    var messages = (data && data.messages) || [];
                    if (!prepend) {
                        resetMessages();
                    }
                    $.each(messages, function (_, message) {
                        renderMessage(message, prepend);
                    });
                    if (!messages.length && !prepend) {
                        $('#chat-message-list').html('<div class="chat-empty">暂无消息</div>');
                    }
                    if (!prepend) {
                        scrollBottom();
                    }
                    return false;
                });
            }

            function closeSocket() {
                authed = false;
                connectingRoomId = 0;
                if (connectTimer) {
                    clearTimeout(connectTimer);
                    connectTimer = null;
                }
                if (heartbeatTimer) {
                    clearInterval(heartbeatTimer);
                    heartbeatTimer = null;
                }
                if (socket) {
                    socket.onclose = null;
                    socket.close();
                    socket = null;
                }
            }

            function connectRoom(room) {
                if (
                    currentRoom &&
                    parseInt(currentRoom.id, 10) === parseInt(room.id, 10) &&
                    connectingRoomId === parseInt(room.id, 10)
                ) {
                    return;
                }

                closeSocket();
                currentRoom = room;
                connectingRoomId = room.id;
                var version = ++connectVersion;
                $('#chat-title').text(room.name);
                $('.chat-room-item').removeClass('active');
                $('.chat-room-item[data-room-id="' + room.id + '"]').addClass('active');
                setStatus('连接中', false);
                loadMessages(false);

                if (!room.ws_url) {
                    setStatus('WebSocket 地址未配置', false);
                    Toastr.error('WebSocket 地址未配置');
                    return;
                }

                Fast.api.ajax({
                    url: 'miniapp/chat_room/wsTicket',
                    loading: false
                }, function (data) {
                    if (version !== connectVersion || !currentRoom || parseInt(currentRoom.id, 10) !== parseInt(room.id, 10)) {
                        return false;
                    }

                    var ticket = data && data.ticket;
                    if (!ticket) {
                        setStatus('获取连接凭证失败', false);
                        connectingRoomId = 0;
                        Toastr.error('获取连接凭证失败');
                        return false;
                    }

                    socket = new WebSocket(room.ws_url);
                    connectTimer = setTimeout(function () {
                        if (version !== connectVersion) {
                            return;
                        }
                        if (!authed) {
                            setStatus('连接超时', false);
                            if (socket) {
                                socket.close();
                            }
                        }
                    }, 10000);

                    socket.onopen = function () {
                        if (version !== connectVersion) {
                            try {
                                socket.close();
                            } catch (e) {}
                            return;
                        }
                        socket.send(JSON.stringify({
                            type: 'auth',
                            actor_type: 'admin',
                            ticket: ticket
                        }));
                    };

                    socket.onmessage = function (event) {
                        if (version !== connectVersion) {
                            return;
                        }
                        var packet;
                        try {
                            packet = JSON.parse(event.data);
                        } catch (e) {
                            return;
                        }
                        if (packet.type === 'auth') {
                            authed = packet.code === 1;
                            setStatus(authed ? '已连接' : (packet.msg || '鉴权失败'), authed);
                            if (connectTimer) {
                                clearTimeout(connectTimer);
                                connectTimer = null;
                            }
                            if (authed) {
                                heartbeatTimer = setInterval(function () {
                                    if (version !== connectVersion) {
                                        return;
                                    }
                                    if (socket && socket.readyState === WebSocket.OPEN) {
                                        socket.send(JSON.stringify({type: 'ping'}));
                                    }
                                }, (Config.heartbeat || 25) * 1000);
                            }
                            return;
                        }
                        if (packet.type === 'message') {
                            $('#chat-message-list .chat-empty').remove();
                            renderMessage(packet.data, false);
                        }
                        if (packet.type === 'error') {
                            Toastr.error(packet.msg || '发送失败');
                        }
                    };

                    socket.onclose = function () {
                        if (version !== connectVersion) {
                            return;
                        }
                        if (connectTimer) {
                            clearTimeout(connectTimer);
                            connectTimer = null;
                        }
                        if (heartbeatTimer) {
                            clearInterval(heartbeatTimer);
                            heartbeatTimer = null;
                        }
                        authed = false;
                        connectingRoomId = 0;
                        setStatus('连接已断开', false);
                    };

                    socket.onerror = function () {
                        if (version !== connectVersion) {
                            return;
                        }
                        connectingRoomId = 0;
                        setStatus('连接异常', false);
                    };
                    return false;
                }, function (data, ret) {
                    if (version !== connectVersion) {
                        return false;
                    }
                    connectingRoomId = 0;
                    setStatus('获取连接凭证失败', false);
                    Toastr.error((ret && ret.msg) || '获取连接凭证失败');
                    return false;
                });
            }

            $('#chat-room-list').on('click', '.chat-room-item', function () {
                var room = getRoom($(this).data('room-id'));
                if (room) {
                    connectRoom(room);
                }
            });

            $('#chat-messages').on('click', '#chat-load-more', function () {
                loadMessages(true);
            });

            $('#chat-content').on('input', function () {
                $('#chat-count').text($(this).val().length);
            });

            $('#chat-send').on('click', function () {
                var content = $.trim($('#chat-content').val());
                if (!currentRoom) {
                    Toastr.warning('请选择聊天室');
                    return;
                }
                if (!content) {
                    Toastr.warning('请输入消息内容');
                    return;
                }
                if (!socket || socket.readyState !== WebSocket.OPEN || !authed) {
                    Toastr.error('WebSocket 未连接');
                    return;
                }
                socket.send(JSON.stringify({
                    type: 'message',
                    content: content
                }));
                $('#chat-content').val('');
                $('#chat-count').text('0');
            });

            if (rooms.length) {
                connectRoom(rooms[0]);
            }
        }
    };

    return Controller;
});
