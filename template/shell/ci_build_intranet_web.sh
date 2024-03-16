#!/bin/bash

set -e
set -v

export JAVA_HOME=/usr/local/java/jdk-17.0.9
export JRE_HOME=$JAVA_HOME/jre
export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
export CLASSPATH=$CLASSPATH:.:$JAVA_HOME/lib:$JRE_HOME/lib

export PATH=$PATH:/var/lib/snapd/snap/bin
export ANDROID_HOME=/home/android-sdk-linux
export PATH=$PATH:/home/android-sdk-linux/platform-tools/

export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

java -version

#NOTIFY_START_CONTENT="Web【内网】开始打包啦！"
#curl --location --request POST 'https://oapi.dingtalk.com/robot/send?access_token=f4f687e2150c2e9ce38dfdb161788ef002b6eba30929799db66df703b4c65b89' \
#-H 'Content-Type: application/json' \
#-d "{\"msgtype\": \"text\",\"text\": {\"content\":\"${NOTIFY_START_CONTENT}\"}}"

FILE_PATH_BASE=/home/gitlab-runner/apk_download/
rm -rf ${FILE_PATH_BASE}/web
#编译打包
flutter build web --dart-define=is_intranet=true --dart-define=is_managerApp=false --base-href="/web/"

mv ./build/web/ ${FILE_PATH_BASE}
WEB_URL="http://192.168.100.99/web/"

cd ${FILE_PATH_BASE}/web

sed -i "26c location.href = \"./h5.html\";" pc.html

mv index.html h5.html
mv pc.html index.html


#钉钉群通知
NOTIFY_CONTENT="#### Web【内网】 \n>"\
"访问地址：[立即访问](${WEB_URL})<br> \n>"

curl --location --request POST 'https://oapi.dingtalk.com/robot/send?access_token=f4f687e2150c2e9ce38dfdb161788ef002b6eba30929799db66df703b4c65b89' \
-H 'Content-Type: application/json' \
-d "{\"msgtype\": \"markdown\",\"markdown\": {\"title\":\"Web【内网】\",\"text\":\"${NOTIFY_CONTENT}\"}}"