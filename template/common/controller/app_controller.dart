import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../i18n/lang.dart';

class AppController extends GetxController {
  var isRunningBackground = false;

  Locale? getLocale() {
    var local = Get.locale;
    var index = 0;
    switch (index) {
      case 1:
        local = const Locale('zh', 'CN');
        break;
      case 2:
        local = const Locale('en', 'US');
        break;
    }
    return local;
  }

  Messages getLangList() {
    return curLang;
  }

  runningBackground(bool run) {
    if (isRunningBackground && !run) {}

    isRunningBackground = run;
  }
}
