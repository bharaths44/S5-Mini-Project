import 'package:e_commerce_flutter/src/view/screen/auth/login/login_controller.dart';
import 'package:e_commerce_flutter/src/view/screen/auth/register/register_controller.dart';
import 'package:e_commerce_flutter/src/view/screen/home_screen/home_controller.dart';
import 'package:get/get.dart';

import '../src/controller/product_controller.dart';

class ProductControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
  }
}

class DashBoardControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashBoardController>(() => DashBoardController());
  }
}

class RegisterControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}

class LoginControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}

class DependencyCreator {
  static init() {
    ProductControllerBinding().dependencies();
    DashBoardControllerBinding().dependencies();
    RegisterControllerBinding().dependencies();
  }
}