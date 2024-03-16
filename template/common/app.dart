import 'dart:ui';

import 'utils/keyboard_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'routers/names.dart';
import 'routers/pages.dart';
import 'utils/logger.dart';
import 'components/app_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppView(
      builder: (locale, list, theme, builder) => GetMaterialApp(
        title: 'LH',
        theme: theme,
        enableLog: true,
        builder: builder,
        debugShowCheckedModeBanner: false,
        logWriterCallback: Logger.print,
        translations: list,
        fallbackLocale: locale,

        locale: locale,
        getPages: AppPages.routes,
        initialBinding: InitBinding(),
        initialRoute: RouteNames.splash,
        scrollBehavior: MyCustomScrollBehavior(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, list) {
          Get.locale ??= locale;
          return locale;
        },
        // 路由回调
        routingCallback: (Routing? routing) {
          if (routing != null) {
            // 路由跳转 关闭键盘
            KeyboardUtil.dismissKeyboard(context);
          }
        },
      ),
    );
  }
}

class InitBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(SelfController());
    // if (Global.box.hasData("curType")) {
    //   SelfController.find.curRole.value = Global.box.read("curType");
    // }
    // Get.put(ConversitionListLogic());
    // Get.put(IMChatLogic());
    // Get.put(IMController());
    // Get.put(IMFloatingWindowLogic());
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
