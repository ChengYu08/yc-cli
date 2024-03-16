import 'dart:async';

class CommonUtils {
  static Timer? _debounceTimer;

  /// 防抖 (传入所要防抖的方法/回调与延迟时间)
  static void debounce(Function func, [int delay = 500]) {
    if (_debounceTimer != null) {
      _debounceTimer?.cancel();
    }
    _debounceTimer = Timer(Duration(milliseconds: delay), () {
      func.call();
      _debounceTimer = null;
    });
  }

  /// 防抖 (传入所要防抖的方法/回调与延迟时间)
  static debounce2(Function func, [int delay = 500]) {
    Timer? timer;
    return () {
      if (timer != null) {
        timer?.cancel();
      }
      timer = Timer(Duration(milliseconds: delay), () {
        func.call();
        timer = null;
      });
    };
  }

  /// 录入框防抖 (传入所要防抖的方法/回调与延迟时间)
  static debounceInput(Function(dynamic) func, [int delay = 500]) {
    Timer? timer;
    return (dynamic value) {
      if (timer != null) {
        timer?.cancel();
      }
      timer = Timer(Duration(milliseconds: delay), () {
        func.call(value);
        timer = null;
      });
    };
  }

  static Timer? _throttleTimer;
  static bool _throttleFlag = true;

  /// 节流 (传入所要节流的方法/回调与延迟时间)
  static void throttle(Function func, [int delay = 500]) {
    if (_throttleFlag) {
      func.call();
      _throttleFlag = false;
      return;
    }
    if (_throttleTimer != null) {
      return;
    }
    _throttleTimer = Timer(Duration(milliseconds: delay), () {
      func.call();
      _throttleTimer = null;
    });
  }

  /// 节流 (传入所要节流的方法/回调与延迟时间)
  static throttle2(Function func, [int delay = 500]) {
    Timer? timer;
    bool firstTime = true;
    return () {
      if (firstTime) {
        func.call();
        firstTime = false;
        return;
      }
      if (timer != null) {
        return;
      }
      timer = Timer(Duration(milliseconds: delay), () {
        func.call();
        timer = null;
      });
    };
  }

  /// 节流 (传入所要节流的方法/回调与延迟时间)
  static throttle3(Function func, [int delay = 500]) {
    Timer? timer;
    bool isExecuting = false;
    return () {
      if (isExecuting) return;
      isExecuting = true;
      timer?.cancel();
      timer = Timer(Duration(milliseconds: delay), () {
        func.call();
        isExecuting = false;
      });
    };
  }
}

// 用法
// CommonUtils.debounce(() => _inputCallBack1(value, true), 500);
// CommonUtils.throttle(() => _clickThrottleBtn1(), 2000);
