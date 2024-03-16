import 'package:flutter/material.dart';

class KeyboardUtil {
  ///关闭键盘
  static dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /// 打开键盘
  static openKeyboard(BuildContext context, FocusNode _inputFocus) {
    FocusScope.of(context).requestFocus(_inputFocus);
  }
}
