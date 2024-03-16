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

#版本号的最后一位+1
increment_version ()
{
  declare -a part=( ${1//\./ } )
  declare    new
  declare -i carry=1
  CNTR=${#part[@]}-1
  len=${#part[CNTR]}
  new=$((part[CNTR]+carry))
  part[CNTR]=${new}
  new="${part[*]}"
  echo -e "${new// /.}"
}

#计算出新的版本号
FILE_PATH_BASE=/home/gitlab-runner/apk_download/out
VERSION_FILE=${FILE_PATH_BASE}/version.json
APK_VERSION=$(cat ${VERSION_FILE} | jq -r .version)
NEW_VERSION=$(increment_version ${APK_VERSION})

#NOTIFY_START_CONTENT="【外网】【外网】【外网】新的apk版本号：${NEW_VERSION}\n开始打包啦！"
#curl --location --request POST 'https://oapi.dingtalk.com/robot/send?access_token=f4f687e2150c2e9ce38dfdb161788ef002b6eba30929799db66df703b4c65b89' \
#-H 'Content-Type: application/json' \
#-d "{\"msgtype\": \"text\",\"text\": {\"content\":\"${NOTIFY_START_CONTENT}\"}}"

#修改打包文件中的版本号
sed -i "19c version: ${NEW_VERSION}" pubspec.yaml

#编译打包
flutter build apk --dart-define=is_intranet=false --dart-define=is_managerApp=false
FileName=`date +%Y%m%d_%H%M%S`_${NEW_VERSION}.apk
DOWNLOAD_URL=http://192.168.100.99/out/${FileName}
mv build/app/outputs/flutter-apk/app-release.apk ${FILE_PATH_BASE}/${FileName}


#更新自动更新配置文件
NEW_VERSION_CONTENT="{\"necessary\":true, \"need\": true, \"version\": \""${NEW_VERSION}"\", \"url\":\""${DOWNLOAD_URL}"\", \"contents\":[]}"
echo ${NEW_VERSION_CONTENT} > ${VERSION_FILE}

#钉钉群通知
NOTIFY_CONTENT="#### Android[外网][外网] \n>"\
"版本号：<font color=Red>${NEW_VERSION}</font> [点击下载](${DOWNLOAD_URL})<br> \n>"\
"备注：外包请下载后自行部署到正式环境！"

curl --location --request POST 'https://oapi.dingtalk.com/robot/send?access_token=f4f687e2150c2e9ce38dfdb161788ef002b6eba30929799db66df703b4c65b89' \
-H 'Content-Type: application/json' \
-d "{\"msgtype\": \"markdown\",\"markdown\": {\"title\":\"Android[外网]\",\"text\":\"${NOTIFY_CONTENT}\"}}"