# Miniapp 接口文档（对齐线上）

## 统一说明
- 基础路径：`/miniapp`
- Content-Type：`application/x-www-form-urlencoded`
- Header：`language`（`zh_cn/en`） 、`token`（登录后必传）
- 成功码：`200`，错误码：`400/401/404/500`
- 返回结构：`{code, msg, time, data}`

## 数据表变更
- 增量 SQL：`database/sql/20260423_miniapp_align_online.sql`
- 新增表：`fa_miniapp_scroll_list`、`fa_miniapp_pay_config`、`fa_miniapp_config`
- 扩展字段：`fa_miniapp_user`（`username, headpic, freeze_balance, level, deal_num, group_id, show_td`）
- 扩展字段：`fa_miniapp_order`（`uid, level_id, parent_uid, num, user_balance, user_freeze_balance, addtime, endtime, is_pay, commission, parent_commission, c_status, add_id, goods_count, shop_name, goods_price, goods_pic, today_dan, qkon, group_id` 等）
- 扩展字段：`fa_miniapp_finance_log`（`uid, sid, oid, num, balance, addtime, f_lv, status`）
- 新增字段：`fa_miniapp_goods.goods_count`，表示商品数量，默认 `1`

---

## 1. 首页 homeNew
- 路径：`GET/POST /miniapp/index/homeNew`
- Header：`token` 必填
- 返回：```json
{
  "balance": "535.22",
  "banner": [{"id":1, "image":"url", "title":null, "url":"link"}],
  "scroll_list": [{"addtime":"04-23", "name":"5232295884", "today_income":73}]
}


## 2. 订单列表 orderRecord
- 路径：`POST /miniapp/order/orderRecord`
- Header：`token` 必填
- 入参：`page`, `size`, `status`，`0=全部`，`1=待完成`，`2=已完成`，`-1=全部含未支付`
- 返回：```json
{
  "status": 1,
  "page": 1,
  "size": 10,
  "balance": "535.22",
  "list": [{
    "oid": 808854,
    "id": "UB2604221943197198",
    "uid": 810870,
    "level_id": 0,
    "parent_uid": 800156,
    "num": "350.00",
    "user_balance": "535.22",
    "user_freeze_balance": "0.00",
    "addtime": 1776876199,
    "term_time": null,
    "endtime": 1776879799,
    "status": 1,
    "is_pay": 1,
    "pay_time": 1776876224,
    "commission": "2.10",
    "parent_commission": "0.32",
    "c_status": 1,
    "add_id": 1,
    "goods_id": 148,
    "goods_count": 2,
    "goods_name": "商品名称",
    "shop_name": "店铺名称",
    "goods_price": "175.00",
    "goods_pic": "https://example.com/pic.jpg",
    "today_dan": 3,
    "qkon": 1,
    "group_id": 0,
    "group_rule_num": 0,
    "group_is_active": 0,
    "group_completedornot": 1,
    "rands": null,
    "group_count": null,
    "duorw": 0,
    "rwdans": null,
    "zhuass": 0,
    "time_limit": 1902
  }],
  "paging": 1
}
```
- 新增说明：
  - `goods_count`：商品数量
  - `goods_price`：商品单价
  - `num`：订单总金额，等于 `goods_price * goods_count`

## 3. 抢单页 rot_order/orderInfo
- 路径：`GET/POST /miniapp/rot_order/orderInfo`
- Header：`token` 必填
- 返回：```json
{
  "lock_deal": "0.00",
  "day_deal": 35.22,
  "completed_count": 19,
  "order_num": 60,
  "level_bili": 0.006,
  "order_incomplete_num": 1,
  "uinfo": {
    "id": 810870,
    "tel": "7859090777",
    "username": "UXE_u0704",
    "invite_code": "195951",
    "balance": "535.22",
    "freeze_balance": "0.00",
    "group_id": 0,
    "level": 0,
    "deal_num": 0
  },
  "price": "535.22",
  "desc_info": "<p>规则说明HTML</p>",
  "deal_zhuji_time": "1",
  "deal_shop_time": "2",
  "commission_today": 8.38,
  "commission_all": 35.22,
  "commission_subordinate": 0,
  "order_undone": {}
}
- `order_undone`：无未完成订单时为 `{}`，有时为订单对象（同 `orderRecord` 列表项结构）
- 新增说明：
  - 下单商品数量来自商品表 `fa_miniapp_goods.goods_count`
  - 订单中的 `goods_count` 会写入未完成订单对象 `order_undone`
  - `dispatch_amount`：当前按规则计算出来的本次派单金额
  - `dispatch_goods_price`：当前商品单价
  - `dispatch_goods_count`：当前商品数量
  - `lack_amount`：余额不足时的差额，余额足够时为 `0.00`
  - `can_submit_order`：当前是否可以抢单，`1=可以`，`0=不可以`
  - `max_order_count`：按当前余额和当前派单金额可抢的最大订单数，计算规则为 `floor(balance / dispatch_amount)`

## 4. 提交订单 rot_order/submit_order
- 路径：`POST /miniapp/rot_order/submit_order`
- Header：`token` 必填
- 入参：无
- 逻辑：有未完成订单则拒绝（400）
- 返回：`{"order_no":"UBxxx", "amount":99}`
- 新增说明：
  - 自动读取商品表 `goods_count` 作为下单数量
  - `amount` 为订单总金额
  - 计算规则：`amount = goods_price * goods_count`
  - 当命中用户设置或默认配置时，会优先按规则里的 `dispatch_amount / commission_rate / fixed_commission` 计算
  - 余额不足时，接口会返回差额相关字段：
  - `balance`：当前用户余额
  - `required_amount`：当前规则要求的下单金额
  - `lack_amount`：当前还差多少钱
  - `max_order_count`：按当前余额最多可抢多少单
  - `goods_price`：当前商品单价
  - `goods_count`：当前商品数量

## 5. 订单详情 order/order_info
- 路径：`POST /miniapp/order/order_info`
- Header：`token` 必填
- 入参：`id`（订单号）
- 返回：```json
{
  "oid": "UB2604221943197198",
  "commission": "2.10",
  "addtime": 1776876199,
  "endtime": "2026/04/22 20:43:19",
  "status": 1,
  "num": "350.00",
  "goods_count": 2,
  "add_id": 1,
  "goods_name": "商品名称",
  "goods_price": "175.00",
  "shop_name": "店铺名称",
  "goods_pic": "https://example.com/pic.jpg",
  "name": null,
  "tel": null,
  "address": null,
  "balance": "535.22",
  "group_rule_num": 0,
  "group_id": 0,
  "rands": null,
  "group_count": null,
  "duorw": 0,
  "is_pay": 1,
  "group_is_active": 0,
  "yuji": 352.1,
  "completedquantity": 1,
  "group_data": [{ "...同上结构..." }]
}

- 新增说明：
  - `goods_count`：商品数量
  - `goods_price`：商品单价
  - `num`：订单总金额，等于 `goods_price * goods_count`

## 6. 完成订单 order/do_order
- 路径：`POST /miniapp/order/do_order`
- Header：`token` 必填
- 入参：`oid`（订单号）
- 逻辑：已完成则拒绝（400），佣金（commission）入账
- 返回：`{"order_no":"UBxxx", "status":2}`

## 7. 团队信息 ctrl/teamAll
- 路径：`POST /miniapp/ctrl/teamAll`
- Header：`token` 必填
- 返回：```json
{
  "team1_count": 0,
  "team1_rebate": 0,
  "team1_rebate_day": 0,
  "list": {}
}

- `list`：无成员时为 `{}`，有成员时为数组

## 8. 提现 ctrl/do_withdraw
- 路径：`POST /miniapp/ctrl/do_withdraw`
- Header：`token` 必填
- 入参：`num`, `type`, `paypassword`
- 逻辑：有未完成订单则拒绝（400），验证资金密码
- 返回：`{"withdraw_no":"WDxxx", "amount":1}`

## 9. 我的主页 my/indexNew
- 路径：`GET/POST /miniapp/my/indexNew`
- Header：`token` 必填
- 返回：```json
{
  "info": {
    "username": "UXE_u0704",
    "tel": "7859090777",
    "level": 0,
    "id": 810870,
    "headpic": "https://example.com/avatar.png",
    "balance": "535.22",
    "freeze_balance": "0.00",
    "invite_code": "195951",
    "show_td": 1
  }
}


## 10. 充值渠道 ctrl/rechargeNew
- 路径：`GET/POST /miniapp/ctrl/rechargeNew`
- Header：`token` 必填
- 返回：```json
{
  "usercode": "TV4pKS2gngbM2Fzjb2RcLNR3prMCYaeWVc",
  "pay": [
    {"usercode":"TV4pKS2gngbM2Fzjb2RcLNR3prMCYaeWVc", "type":"USDT-TRC20"}
  ]
}


## 11. 用户资料 my/userInfo
- 路径：`GET/POST /miniapp/my/userInfo`
- Header：`token` 必填
- 返回：```json
{
  "info": {
    "balance": "535.22",
    "username": "UXE_u0704",
    "tel": "7859090777",
    "usdt_diz": "TRON_ADDRESS"
  }
}
```

## 12. 保存用户资料 my/uinfoSave
- 路径：`POST /miniapp/my/uinfoSave`
- Header：`token` 必填
- 入参：`pwd`（必填，提款/资金密码）, `pwd_new`（可选，新登录密码，空则不修改）
- 逻辑：验证提款/资金密码；`pwd_new` 不为空时修改登录密码
- 返回：成功返回 `null`

## 13. 资金流水 my/caiwu
- 路径：`POST /miniapp/my/caiwu`
- Header：`token` 必填
- 入参：`page`, `size`, `type`（`0=全部, 1=入金, 7=出金`）, `start`, `end`
- 返回：```json
{
  "page": "1",
  "size": "10",
  "start": "",
  "end": "",
  "list": [{
    "id": 4509053,
    "uid": 810870,
    "sid": 810870,
    "oid": "UB2604221943197198",
    "num": "2.10",
    "balance": 533.12,
    "type": 3,
    "status": 1,
    "addtime": 1776876224,
    "f_lv": null
  }],
  "paging": 1
}

## 14. 设置资金密码 my/setCashPwd
- 路径：`POST /miniapp/my/setCashPwd`
- Header：`token` 必填
- 入参：`pwd`, `pwd_new`, `address`（可选）
- 逻辑：验证原资金密码后设置新资金密码
- 返回：成功返回 `null`

## 15. 设置语言 support/setLanguage
- 路径：`POST /miniapp/support/setLanguage`
- 入参：`language`（`1=中文, 2=英文`）
- 返回：`{"language":2, "language_name":"English"}`

## 16. 全局信息 support/index
- 路径：`GET/POST /miniapp/support/index`
- 返回：`{"language":1, "language_name":"中文", "contact":{...}}`

## 未在 curl 文档中但已实现
- `POST /miniapp/user/do_login`，登录
- `POST /miniapp/user/do_register`，注册
- `POST /miniapp/user/logout`，退出
