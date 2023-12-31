import 'package:e_commerce_flutter/core/dependency.dart';
import 'package:e_commerce_flutter/src/customerview/view/screen/home_screen/home_screen.dart';
import 'package:get/get.dart';

import '../src/auth/login/login_screen.dart';
import '../src/auth/register/register_screen.dart';

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: '/home/',
      page: () => HomeScreen(),
      binding: DashBoardControllerBinding(),
    ),
    GetPage(
      name: '/login/',
      page: () => LoginScreen(),
      binding: LoginControllerBinding(),
    ),
    GetPage(
      name: '/register/',
      page: () => const RegisterScreen(),
      binding: RegisterControllerBinding(),
    )
  ];
}
