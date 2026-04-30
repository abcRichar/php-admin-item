#!/usr/bin/env bash

BASE_URL="${BASE_URL:-http://127.0.0.1/miniapp}"
TOKEN="${TOKEN:-f15854f6afb9eba1394b4d6dc4809a58}"
COMMON_HEADERS=(
  -H 'accept: */*'
  -H 'accept-language: zh-CN,zh;q=0.9'
  -H 'content-type: application/x-www-form-urlencoded'
  -H 'language: zh_cn'
  -H 'origin: https://ali1776756484279.aliexpressapp.one'
  -H 'priority: u=1, i'
  -H 'referer: https://ali1776756484279.aliexpressapp.one/'
  -H 'sec-ch-ua: "Google Chrome";v="147", "Not.A/Brand";v="8", "Chromium";v="147"'
  -H 'sec-ch-ua-mobile: ?1'
  -H 'sec-ch-ua-platform: "iOS"'
  -H 'sec-fetch-dest: empty'
  -H 'sec-fetch-mode: cors'
  -H 'sec-fetch-site: cross-site'
  -H "token: ${TOKEN}"
  -H 'user-agent: Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1'
)

curl "${BASE_URL}/index/homeNew" "${COMMON_HEADERS[@]}"
curl "${BASE_URL}/support/index" "${COMMON_HEADERS[@]}"
curl "${BASE_URL}/order/orderRecord" "${COMMON_HEADERS[@]}" --data-raw 'page=1&size=10&status=1'
curl "${BASE_URL}/rot_order/orderInfo" "${COMMON_HEADERS[@]}"
curl "${BASE_URL}/rot_order/submit_order" -X POST "${COMMON_HEADERS[@]}"
curl "${BASE_URL}/order/order_info" "${COMMON_HEADERS[@]}" --data-raw 'id=UB2604211244045130'
curl "${BASE_URL}/order/do_order" "${COMMON_HEADERS[@]}" --data-raw 'oid=UB2604211244045130'
curl "${BASE_URL}/ctrl/teamAll" -X POST "${COMMON_HEADERS[@]}"
curl "${BASE_URL}/my/indexNew" "${COMMON_HEADERS[@]}"
curl "${BASE_URL}/ctrl/do_withdraw" "${COMMON_HEADERS[@]}" --data-raw 'num=11&type=bank&paypassword=11'
curl "${BASE_URL}/my/userInfo" "${COMMON_HEADERS[@]}"
curl "${BASE_URL}/my/uinfoSave" "${COMMON_HEADERS[@]}" --data-raw 'address=%E6%B5%8B%E8%AF%95&pwd=13&pwd_new=123'
curl "${BASE_URL}/my/setCashPwd" "${COMMON_HEADERS[@]}" --data-raw 'pwd=1&pwd_new=1&pwd_new_confirm=1&address='
curl "${BASE_URL}/my/caiwu" "${COMMON_HEADERS[@]}" --data-raw 'page=1&size=10&type=1'
curl "${BASE_URL}/user/logout" -X POST "${COMMON_HEADERS[@]}"
curl "${BASE_URL}/user/do_login" "${COMMON_HEADERS[@]}" --data-raw 'tel=7859090777&pwd=123123'
