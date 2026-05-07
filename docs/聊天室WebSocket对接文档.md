# 聊天室 WebSocket 对接文档

## 1. 基本说明

聊天室为 3 个固定房间，每个房间对应一个独立 WebSocket 链接。

小程序进入哪个聊天室，就连接哪个房间的 WebSocket 链接。连接成功后必须先发送鉴权消息，鉴权通过后才能发送文字消息。

当前仅支持文字消息。

## 2. 房间与 WebSocket 链接

### 2.1 开发环境

开发环境可直接连接 WebSocket 服务端口：

| 房间 | WebSocket 链接 |
| --- | --- |
| 聊天室 1 | `ws://127.0.0.1:8282/room/1` |
| 聊天室 2 | `ws://127.0.0.1:8282/room/2` |
| 聊天室 3 | `ws://127.0.0.1:8282/room/3` |

### 2.2 线上环境

线上环境使用 Nginx 反向代理，不直接暴露 `8282` 端口。

| 房间 | WebSocket 链接 |
| --- | --- |
| 聊天室 1 | `wss://{domain}/wss/room/1` |
| 聊天室 2 | `wss://{domain}/wss/room/2` |
| 聊天室 3 | `wss://{domain}/wss/room/3` |

正式域名示例：

```text
wss://www.xinyongcha.top/wss/room/1
wss://www.xinyongcha.top/wss/room/2
wss://www.xinyongcha.top/wss/room/3
```

说明：

- `{domain}`：线上 HTTPS 域名，例如 `www.xinyongcha.top`
- 房间 ID 固定为 `1`、`2`、`3`
- 连接 `/room/1` 后只收发聊天室 1 的消息，不能在同一个连接里切换房间
- 小程序正式环境必须使用 `wss://`

## 3. HTTP 接口

### 3.1 获取聊天室列表

```http
GET /miniapp/chat/rooms
Header: token: 用户登录 token
```

返回示例：

```json
{
  "code": 1,
  "msg": "success",
  "data": {
    "rooms": [
      {
        "id": 1,
        "name": "聊天室 1",
        "ws_url": "wss://www.xinyongcha.top/wss/room/1"
      },
      {
        "id": 2,
        "name": "聊天室 2",
        "ws_url": "wss://www.xinyongcha.top/wss/room/2"
      },
      {
        "id": 3,
        "name": "聊天室 3",
        "ws_url": "wss://www.xinyongcha.top/wss/room/3"
      }
    ]
  }
}
```

### 3.2 获取历史消息

```http
GET /miniapp/chat/messages?room_id=1&page=1&size=20
Header: token: 用户登录 token
```

参数：

| 参数 | 必填 | 说明 |
| --- | --- | --- |
| `room_id` | 是 | 房间 ID：`1`、`2`、`3` |
| `page` | 否 | 页码，默认 `1` |
| `size` | 否 | 每页数量，默认 `20`，最大 `100` |

返回示例：

```json
{
  "code": 1,
  "msg": "success",
  "data": {
    "room_id": 1,
    "page": 1,
    "size": 20,
    "total": 2,
    "messages": [
      {
        "id": 100,
        "room_id": 1,
        "sender_type": "user",
        "sender_id": 10001,
        "sender_name": "测试用户",
        "message_type": "text",
        "content": "你好",
        "create_time": 1777820000,
        "time_text": "2026-05-03 23:00:00"
      }
    ]
  }
}
```

### 3.3 获取 WebSocket 配置

```http
GET /miniapp/chat/wsConfig
Header: token: 用户登录 token
```

返回 3 个房间的 WebSocket 地址，以及鉴权协议示例。

返回示例：

```json
{
  "code": 1,
  "msg": "success",
  "data": {
    "rooms": [
      {
        "room_id": 1,
        "name": "聊天室 1",
        "ws_url": "wss://www.xinyongcha.top/wss/room/1"
      }
    ],
    "token": "用户登录 token",
    "heartbeat": 25,
    "protocol": {
      "auth": {
        "type": "auth",
        "actor_type": "user",
        "token": "用户登录 token"
      },
      "message": {
        "type": "message",
        "content": "hello"
      }
    }
  }
}
```

## 4. WebSocket 协议

### 4.1 建立连接

小程序连接指定房间：

```js
const socketTask = wx.connectSocket({
  url: 'wss://www.xinyongcha.top/wss/room/1'
})
```

### 4.2 鉴权

连接打开后必须先发送鉴权消息：

```json
{
  "type": "auth",
  "actor_type": "user",
  "token": "用户登录 token"
}
```

鉴权成功返回：

```json
{
  "type": "auth",
  "code": 1,
  "msg": "ok",
  "room_id": 1
}
```

鉴权失败返回：

```json
{
  "type": "auth",
  "code": 0,
  "msg": "登录已失效"
}
```

### 4.3 发送文字消息

鉴权成功后发送：

```json
{
  "type": "message",
  "content": "你好"
}
```

说明：

- 不需要传 `room_id`
- 房间由 WebSocket 链接决定
- 消息内容不能为空
- 消息最大长度为 `1000` 字符

### 4.4 接收新消息

服务端广播消息：

```json
{
  "type": "message",
  "data": {
    "id": 101,
    "room_id": 1,
    "sender_type": "user",
    "sender_id": 10001,
    "sender_name": "测试用户",
    "message_type": "text",
    "content": "你好",
    "create_time": 1777820000,
    "time_text": "2026-05-03 23:00:00"
  }
}
```

`sender_type` 说明：

| 值 | 说明 |
| --- | --- |
| `user` | 小程序用户 |
| `admin` | 后台人员 |

### 4.5 心跳

建议小程序每 `25` 秒发送一次：

```json
{
  "type": "ping"
}
```

服务端返回：

```json
{
  "type": "pong",
  "time": 1777820000
}
```

### 4.6 错误消息

```json
{
  "type": "error",
  "msg": "消息内容不能为空"
}
```

## 5. 小程序示例代码

```js
let socketTask = null
let heartbeatTimer = null
let authed = false

function connectChatRoom(roomWsUrl, token) {
  closeChatRoom()

  socketTask = wx.connectSocket({
    url: roomWsUrl
  })

  socketTask.onOpen(() => {
    socketTask.send({
      data: JSON.stringify({
        type: 'auth',
        actor_type: 'user',
        token
      })
    })
  })

  socketTask.onMessage((res) => {
    let packet = null
    try {
      packet = JSON.parse(res.data)
    } catch (e) {
      return
    }

    if (packet.type === 'auth') {
      authed = packet.code === 1
      if (authed) {
        startHeartbeat()
      }
      return
    }

    if (packet.type === 'message') {
      console.log('new message:', packet.data)
      return
    }

    if (packet.type === 'error') {
      wx.showToast({
        title: packet.msg || '发送失败',
        icon: 'none'
      })
    }
  })

  socketTask.onClose(() => {
    authed = false
    stopHeartbeat()
  })

  socketTask.onError(() => {
    authed = false
    stopHeartbeat()
  })
}

function sendChatMessage(content) {
  const text = String(content || '').trim()
  if (!text) {
    wx.showToast({
      title: '请输入消息内容',
      icon: 'none'
    })
    return
  }

  if (!socketTask || !authed) {
    wx.showToast({
      title: '聊天室未连接',
      icon: 'none'
    })
    return
  }

  socketTask.send({
    data: JSON.stringify({
      type: 'message',
      content: text
    })
  })
}

function startHeartbeat() {
  stopHeartbeat()
  heartbeatTimer = setInterval(() => {
    if (!socketTask || !authed) {
      return
    }
    socketTask.send({
      data: JSON.stringify({
        type: 'ping'
      })
    })
  }, 25000)
}

function stopHeartbeat() {
  if (heartbeatTimer) {
    clearInterval(heartbeatTimer)
    heartbeatTimer = null
  }
}

function closeChatRoom() {
  authed = false
  stopHeartbeat()
  if (socketTask) {
    socketTask.close()
    socketTask = null
  }
}
```

## 6. 切换聊天室

切换房间时必须关闭旧连接，再连接新房间链接：

```js
// 进入聊天室 1
connectChatRoom('wss://www.xinyongcha.top/wss/room/1', token)

// 切换到聊天室 2
connectChatRoom('wss://www.xinyongcha.top/wss/room/2', token)
```

不要在同一个 WebSocket 连接里通过发送 `room_id` 切换房间。

## 7. 服务端启动

启动 WebSocket 服务：

```bash
php think miniapp_chat_server start --host=0.0.0.0 --port=8282
```

开发环境可直接连接：

```text
ws://127.0.0.1:8282/room/1
ws://127.0.0.1:8282/room/2
ws://127.0.0.1:8282/room/3
```

线上环境建议用 PM2 或服务管理工具守护 PHP 常驻进程。

## 8. Nginx 反向代理示例

宝塔当前站点 Nginx 配置中添加：

```nginx
location /wss/ {
    proxy_pass http://127.0.0.1:8282/;

    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "Upgrade";

    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    proxy_read_timeout 60000s;
    proxy_send_timeout 60000s;
}
```

配置后，小程序使用：

```text
wss://www.xinyongcha.top/wss/room/1
wss://www.xinyongcha.top/wss/room/2
wss://www.xinyongcha.top/wss/room/3
```

不要使用：

```text
wss://www.xinyongcha.top:8282/room/1
```

原因：`8282` 是本机 WebSocket 服务端口，线上应通过 Nginx 的 HTTPS/WSS 反向代理访问。

## 9. 注意事项

- 小程序正式环境必须使用 `wss://`
- 微信小程序后台需要配置 WebSocket 合法域名：`wss://www.xinyongcha.top`
- 不需要在微信后台配置 `wss://www.xinyongcha.top:8282`
- 连接成功不代表登录成功，必须等待 `type=auth` 且 `code=1`
- 消息发送后由服务端广播回来，前端以广播消息为准追加到列表
- 历史消息使用 HTTP 接口分页获取，实时消息使用 WebSocket 接收
- 断线后前端可自行重连，但要避免高频重连
