import 'package:e_commerce_flutter/src/view/screen/home_screen/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/src/view/screen/cart_screen/cart_screen.dart';
import 'package:e_commerce_flutter/src/view/screen/profile_screen/profile_screen.dart';
import 'package:e_commerce_flutter/src/view/screen/favorite_screen/favorite_screen.dart';
import 'package:e_commerce_flutter/src/view/screen/home_screen/product_list_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final DashBoardController controller = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex.value,
            children: [
              ProductListScreen(),
              const FavoriteScreen(),
              const CartScreen(),
              const ProfileScreen()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            fixedColor: const Color(0xFFEC6813),
            unselectedItemColor: Colors.grey,
            currentIndex: controller.tabIndex.value,
            items: const [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "Favorite",
                icon: Icon(Icons.favorite),
              ),
              BottomNavigationBarItem(
                label: "Cart",
                icon: Icon(Icons.shopping_cart),
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(Icons.person),
              ),
            ],
            onTap: controller.changeTabIndex),
      );
    });
  }
}
