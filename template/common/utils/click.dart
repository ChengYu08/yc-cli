import 'dart:async';

/**
 * 
 * 
    final ClickHandler clickHandler = ClickHandler();

    clickHandler.handleClick(() {
      // 在这里执行按钮点击后的操作
      print('Button clicked');
    });
 */

class ClickHandler {
  bool _isClickable = true;

  void handleClick(Function action) {
    if (_isClickable) {
      _isClickable = false;
      action();

      Timer(const Duration(seconds: 2), () {
        _isClickable = true;
      });
    }
  }
}
