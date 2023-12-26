import 'package:e_commerce_flutter/src/customerview/controller/firebase_functions.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  Rx<List<Map<String, dynamic>>> orders = Rx<List<Map<String, dynamic>>>([]);

  void loadOrders(String userId) async {
    List<Object?> userOrders = await FirebaseFunctions().getUserOrders(userId);
    orders.value = userOrders.cast<Map<String, dynamic>>();
  }
}