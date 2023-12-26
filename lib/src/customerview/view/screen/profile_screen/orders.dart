import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_flutter/src/customerview/view/screen/profile_screen/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controller/product_controller.dart';

class OrderScreen extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());
  final ProductController controller = Get.find<ProductController>();

  OrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    String? userId = controller.userid;
    orderController.loadOrders(userId!);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFf16b26),
        title: const Text("Your Orders",
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.w300,
            )),
      ),
      body: Obx(() {
        if (orderController.orders.value.isEmpty) {
          return const Center(child: Text('No orders found'));
        } else {
          return ListView.builder(
            itemCount: orderController.orders.value.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> order = orderController.orders.value[index];
              List<Map<String, dynamic>> cartProducts =
                  List<Map<String, dynamic>>.from(order['cartProducts'] ?? []);
              Timestamp timestamp = order['timestamp'];
              String formattedDate =
                  DateFormat('dd MMMM yyyy').format(timestamp.toDate());

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title: Text(
                    'Order ${index + 1}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Total price: ₹${order['totalPrice']}\nDate: $formattedDate',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  children: cartProducts.map((product) {
                    return ListTile(
                      leading: const Icon(Icons.shopping_cart_outlined),
                      title: Text(
                        'Product: ${product['name']}',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      subtitle: Text(
                        'Quantity: ${product['quantity']}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[700],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
