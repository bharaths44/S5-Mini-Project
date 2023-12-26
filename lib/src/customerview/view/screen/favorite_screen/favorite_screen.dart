import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/src/customerview/controller/product_controller.dart';
import 'package:e_commerce_flutter/src/widget/product_grid_view.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);
  final controller = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      init: controller,
      builder: (controller) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: const Color(0xFFf16b26),
            title: const Text("Favorites",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w300,
                )),
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
