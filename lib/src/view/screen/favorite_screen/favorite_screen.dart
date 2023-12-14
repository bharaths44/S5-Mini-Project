import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/src/controller/product_controller.dart';
import 'package:e_commerce_flutter/src/view/widget/product_grid_view.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);
  final controller = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      init: controller, // Initialize the controller here
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Favorites",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ProductGridView(
              items: controller.favoriteProducts,
            ),
          ),
        );
      },
    );
  }
}
