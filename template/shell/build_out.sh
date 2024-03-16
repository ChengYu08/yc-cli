# 打包外网环境

flutter build apk --dart-define=is_intranet=false --dart-define=is_managerApp=false

flutter build web --dart-define=is_intranet=false --dart-define=is_managerApp=false

#flutter build ipa --dart-define=is_intranet=false --dart-define=is_managerApp=false --split-debug-info --tree-shake-icons
