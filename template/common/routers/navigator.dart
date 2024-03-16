import 'package:get/get.dart';
import 'names.dart';

class Nav {
  Nav._();

  // 返回首页
  static void backMainHome() {
    Get.until(
      (route) => Get.currentRoute == RouteNames.home,
    );
  }

  // 拦截返回事件 手动调用返回
  static Future<bool> onBackPressed() async {
    backMainHome();
    return false;
  }

  // 跳转到首页
  static void toGoHome() {
    Get.toNamed(RouteNames.home);
  }
}
