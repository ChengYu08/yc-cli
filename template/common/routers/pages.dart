import 'package:get/get.dart';
import "../pages/index.dart";
import 'names.dart';

class AppPages {
  static _pageBuilder({
    required String name,
    required GetPageBuilder page,
    Bindings? binding,
    bool preventDuplicates = true,
  }) =>
      GetPage(
        name: name,
        page: page,
        binding: binding,
        preventDuplicates: preventDuplicates,
        transition: Transition.cupertino,
        popGesture: true,
      );

  static final routes = <GetPage>[
    _pageBuilder(
      name: RouteNames.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    _pageBuilder(
      name: RouteNames.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    _pageBuilder(
      name: RouteNames.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
