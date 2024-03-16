# 打包内网环境

flutter build apk --dart-define=is_intranet=true --dart-define=is_managerApp=false 
# flutter build web --dart-define=is_intranet=true --dart-define=is_managerApp=false  --base-href="/web/"
# flutter build ipa --dart-define=is_intranet=true --dart-define=is_managerApp=false 