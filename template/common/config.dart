import 'dart:async';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'extension/custom_ext.dart';
import 'i18n/index.dart';
import 'utils/events.dart';

class Config {
  static final getIt = GetIt.instance;

  static final box = GetStorage();

  static final botToastBuilder = BotToastInit();

  static Future init(Function() runApp) async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      final lang = Messages();
      await lang.loadJSON();
      // 全局依赖注入
      getIt.registerSingleton<Langs>(Langs(lang: lang));
      getIt.registerSingleton<Emitter>(Emitter());
      await GetStorage.init();
      FlutterError.onError = (FlutterErrorDetails details) {
        // 这里可以处理或记录错误，比如打印错误信息
        "[error] ${details.exceptionAsString()}".log();
      };
    } catch (_) {}

    runApp();

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    var brightness =
        !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
    ));
  }

  static late String cachePath;

  static const uiW = 375.0;
  static const uiH = 812.0;

  static const String host = isIntranet
      ? 'http://lstest.wbnr.xyz/api' //裘斯本地服务器
      // ? 'http://192.168.100.89:8088/api' //巴兹比本地服务器
      // ? 'http://192.168.101.250:8088/api' //葛纳尔本地服务器
      : 'https://ls.wbnr.xyz/api';

  static const double textScaleFactor = 1.0;

  // 是否是内网
  static const isIntranet = String.fromEnvironment('is_intranet') == "" ||
      String.fromEnvironment('is_intranet') == "true";
}
