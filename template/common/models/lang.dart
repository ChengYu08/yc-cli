// 多语言列表 选项
import 'package:flutter/material.dart';

class LangLocaleItem {
  final String code;
  final String name;
  final String? countryCode;

  get locale => countryCode == null ? Locale(code) : Locale(code, countryCode);

  const LangLocaleItem({
    required this.code,
    required this.name,
    this.countryCode,
  });
}

/**
 *  code
 *  
https://github.com/unicode-org/cldr/blob/main/common/validity/language.xml
 */
