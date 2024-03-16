import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../config.dart';
import '../models/lang.dart';
import '../utils/events.dart';

// 当前多语言
class Messages extends Translations {
  Map<String, Map<String, String>> langs = {};
  final getIt = GetIt.instance;

  @override
  Map<String, Map<String, String>> get keys => langs;
  // 当前语言
  LangLocaleItem curLang = const LangLocaleItem(code: 'zh', name: '中文');

  List<LangLocaleItem> get langsList {
    return langs.keys.map((e) {
      final arr = e.split('_');
      if (arr.length == 2) {
        return LangLocaleItem(code: arr[0], name: arr[0], countryCode: arr[1]);
      } else {
        return LangLocaleItem(code: arr[0], name: arr[0]);
      }
    }).toList();
  }

  // 当前语言
  final defaultLang = const LangLocaleItem(code: 'en', name: 'English');

  // 切换语言
  updateLocale(String? lang) {
    Config.box.write('lang', lang);
    int idx = langsList.indexWhere((r) => r.code == lang);
    if (idx != -1) {
      curLang = langsList[idx];
      Get.updateLocale(curLang.locale);
      final event = Config.getIt.get<Emitter>();
      event.emit(Events.changeLocalLang);
      return;
    }
    Get.updateLocale(Locale(lang ?? "en"));
  }

  // 获取默认本地的多语言数据
  getDefaultLang() async {
    // 文件存在状态
    String jsonString = await rootBundle.loadString('assets/lang/langs.json');
    // 2.转成map类型
    Map<String, dynamic> map = json.decode(jsonString);
    Map<String, Map<String, String>> resultMap = {
      for (var key in map.keys)
        key: Map<String, String>.from(
            map[key].map((k, v) => MapEntry<String, String>(k, v as String)))
    };
    langs = resultMap;
  }

  // 加载语言包
  Future loadJSON() async {
    await getDefaultLang();
    return langs;
  }
}

Messages curLang = Messages();
