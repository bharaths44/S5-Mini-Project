import 'package:e_commerce_flutter/src/controller/firebase_auth.dart';
import 'package:e_commerce_flutter/src/controller/product_controller.dart';
import 'package:e_commerce_flutter/src/view/widget/list_item_selector.dart';
import 'package:e_commerce_flutter/src/view/widget/product_grid_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatelessWidget {
  final controller = Get.put(ProductController());

  ProductListScreen({super.key});
  Widget _topCategoriesHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Categories",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }

  Widget _topCategoriesListView() {
    return ListItemSelector(
      categories: controller.categories,
      onItemPressed: (index) {
        controller.filterItemsByCategory(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
   var username = user?.displayName ?? "Guest";
    controller.getAllItems();
    return FutureBuilder<String>(
      future: getUserName(user),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          String username = snapshot.data ?? "Guest";
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(backgroundColor: const Color(0xFFf16b26)),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello $username',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        "Lets gets somethings?",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      _topCategoriesHeader(context),
                      _topCategoriesListView(),
                      GetBuilder(builder: (ProductController controller) {
                        return ProductGridView(
                          items: controller.filteredProducts,
                          likeButtonPressed: (index) =>
                              controller.isFavorite(index),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
