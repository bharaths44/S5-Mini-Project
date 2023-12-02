import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/core/app_color.dart';
import 'package:e_commerce_flutter/src/controller/product_controller.dart';
import 'package:e_commerce_flutter/src/view/widget/product_grid_view.dart';
import 'package:e_commerce_flutter/src/view/widget/list_item_selector.dart';

enum AppbarActionType { leading, trailing }

final ProductController controller = Get.put(ProductController());

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  Widget appBarActionButton(AppbarActionType type) {
    IconData icon = Icons.ac_unit_outlined;

    if (type == AppbarActionType.trailing) {
      icon = Icons.search;
    }

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.lightGrey,
      ),
      child: IconButton(
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(),
        onPressed: () {},
        icon: Icon(icon, color: Colors.black),
      ),
    );
  }

  Widget _topCategoriesHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Top categories",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(foregroundColor: AppColor.darkOrange),
            child: Text(
              "SEE ALL",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.deepOrange.withOpacity(0.7)),
            ),
          )
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
    String username = user?.displayName ?? "Guest";
    controller.getAllItems();
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
                  style: Theme.of(context).textTheme.displayLarge,
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
                    likeButtonPressed: (index) => controller.isFavorite(index),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
