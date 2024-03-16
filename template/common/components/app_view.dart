import '../config.dart';
import '../controller/app_controller.dart';
import '../i18n/lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'custom_focus_detector.dart';

class AppView extends StatelessWidget {
  const AppView({Key? key, required this.builder}) : super(key: key);
  final Widget Function(Locale? locale, Messages list, ThemeData theme,
      TransitionBuilder builder) builder;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      init: AppController(),
      builder: (ctrl) => FocusDetector(
        onForegroundGained: () => ctrl.runningBackground(false),
        onForegroundLost: () => ctrl.runningBackground(true),
        child: ScreenUtilInit(
          designSize: const Size(Config.uiW, Config.uiH),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) => builder(
              ctrl.getLocale(), ctrl.getLangList(), getThemeData(), _builder()),
        ),
      ),
    );
  }

  static ThemeData getThemeData() {
    return ThemeData(
      useMaterial3: false,
      platform: TargetPlatform.iOS,
      fontFamily: "pingFang",
      // 页面背景色
      scaffoldBackgroundColor: const Color(0xffffffff),
      // 输入框焦点颜色
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.black),
      // 主题色
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffffffff)),
    );
  }

  static TransitionBuilder _builder() => FlutterSmartDialog.init(
        builder: (context, widget) {
          widget = Config.botToastBuilder(context, widget);
          widget = MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: Config.textScaleFactor,
            ),
            child: SafeArea(
              top: false,
              bottom: false,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: widget,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          return widget;
        },
      );
}
