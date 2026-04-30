@echo off
chcp 65001 >nul
set T=1ebe74c4773f4104c87f5e79cb16045c
set B=http://localhost:8080/index.php

echo === 1. homeNew ===
curl -s "%B%/miniapp/index/homeNew" -H "language: zh_cn" -H "token: %T%"
echo.

echo === 2. orderRecord status=1 ===
curl -s "%B%/miniapp/order/orderRecord" -H "language: zh_cn" -H "token: %T%" -d "page=1&size=10&status=1"
echo.

echo === 3. orderRecord status=-1 ===
curl -s "%B%/miniapp/order/orderRecord" -H "language: zh_cn" -H "token: %T%" -d "page=1&size=10&status=-1"
echo.

echo === 4. rot_order/orderInfo ===
curl -s "%B%/miniapp/rot_order/orderInfo" -H "language: zh_cn" -H "token: %T%"
echo.

echo === 5. ctrl/teamAll ===
curl -s -X POST "%B%/miniapp/ctrl/teamAll" -H "language: zh_cn" -H "token: %T%" -H "content-type: application/x-www-form-urlencoded"
echo.

echo === 6. my/indexNew ===
curl -s "%B%/miniapp/my/indexNew" -H "language: zh_cn" -H "token: %T%"
echo.

echo === 7. ctrl/rechargeNew ===
curl -s "%B%/miniapp/ctrl/rechargeNew" -H "language: zh_cn" -H "token: %T%"
echo.

echo === 8. my/userInfo ===
curl -s "%B%/miniapp/my/userInfo" -H "language: zh_cn" -H "token: %T%"
echo.

echo === 9. my/caiwu type=9 ===
curl -s "%B%/miniapp/my/caiwu" -H "language: zh_cn" -H "token: %T%" -d "page=1&size=10&type=9"
echo.