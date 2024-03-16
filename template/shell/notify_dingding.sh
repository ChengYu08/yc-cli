#!/bin/bash
curl --location --request POST 'https://oapi.dingtalk.com/robot/send?access_token=f4f687e2150c2e9ce38dfdb161788ef002b6eba30929799db66df703b4c65b89' \
--header 'User-Agent: Apifox/1.0.0 (https://apifox.com)' \
--header 'Content-Type: application/json' \
--header 'Accept: */*' \
--header 'Host: oapi.dingtalk.com' \
--header 'Connection: keep-alive' \
--data-raw '{"msgtype": "text","text": {"content":"新包来啦, \n${1}"}}'