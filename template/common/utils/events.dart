class Emitter {
  Map events = {};

  emit<T>(String event, [dynamic data]) {
    if (event.isEmpty) {
      return;
    }
    if (events[event] is List) {
      for (Function fn in events[event]) {
        // KLogUtil.d("data $data  fn $fn");
        if (data == null) {
          fn.call();
        } else {
          fn(data);
        }
        // fn(data ?? "");
        // fn.call(data ?? "");
      }
    }
    return this;
  }

  on(String event, Function fn) {
    if (events[event] is List) {
      events[event].add(fn);
    } else {
      events[event] = [fn];
    }

    return this;
  }

  off(String event, Function fn) {
    if (event.isNotEmpty) {
      List? listeners = events[event];
      if (listeners != null) {
        listeners.removeWhere((element) => element == fn);
      } else {
        events[event] = [];
      }
    }
    return this;
  }
}

class Events {
  // 用于类型app重启
  static const appRestart = "app_restart";

  // 需求状态更新
  static const String otherStateUpdate = "otherStateUpdate";

  static const String homeTabChangeUpdate = "homeTabChangeUpdate";

  // 需求状态更新
  static const String takerOrderHomePageUpdate = "takerOrderHomePageUpdate";

  static const String issuerHomeNeedList = "issuerHomeNeedList";

  static const String issuerNeedList = "issuerNeedList";

  // 派单员 订单列表更新
  static const String issuerOrderList = "issuerOrderList";

  // 订单列表更新
  static const String orderStateUpdate = "orderStateUpdate";

  // 更新多语言
  static const String updateLang = "updateLang";

  // 个人用户信息 更新
  static const String userInfoUpdate = "userInfoUpdate";

  // 个人详情 返回刷新首页
  static const String issuerDetailReturn = "issuerDetailReturn";

  // 更新 接单员 我的 的列表
  static const String updateTakerPersonList = "updateTakerPersonList";

  // 消息未读数
  static const String messageNotReadCount = "messageNotReadCount";

  // 切换本地多语言
  static const String changeLocalLang = "changeLocalLang";

  // 更新底部导航栏
  static const String changeBottomNavBottom = "changeBottomNavBottom";

  // Captcha 执行登录逻辑
  static const String captchaLogin = "captchaLogin";

  // Captcha 执行发送验证码逻辑
  static const String captchSendMsg = "captchSendMsg";
}
