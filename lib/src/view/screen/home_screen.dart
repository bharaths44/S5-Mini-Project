import 'package:e_commerce_flutter/src/controller/home_controller.dart';
import 'package:e_commerce_flutter/src/view/widget/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:e_commerce_flutter/core/app_data.dart';
import 'package:e_commerce_flutter/src/view/screen/cart_screen.dart';
import 'package:e_commerce_flutter/src/view/screen/profile_screen.dart';
import 'package:e_commerce_flutter/src/view/screen/favorite_screen.dart';
import 'package:e_commerce_flutter/src/view/screen/product_list_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  static const List<Widget> screens = [
    ProductListScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen()
  ];

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
  final DashBoardController controller = Get.put(DashBoardController());
  // int newIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex.value,
            children: const [
              ProductListScreen(),
              FavoriteScreen(),
              CartScreen(),
              ProfileScreen()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            fixedColor: Color(0xFFEC6813),
            unselectedItemColor: Colors.grey,
            currentIndex: controller.tabIndex.value,
            items: const [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home),
                // backgroundColor: Color(0xFFEC6813),
              ),
              BottomNavigationBarItem(
                label: "Favorite",
                icon: Icon(Icons.favorite),
                //backgroundColor: Color(0xFFEC6813),
                // Colors.grey,
              ),
              BottomNavigationBarItem(
                label: "Cart",
                icon: Icon(Icons.shopping_cart),
                // backgroundColor: Color(0xFFEC6813),
                //Colors.grey,
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(Icons.person),
                // backgroundColor: Color(0xFFEC6813),
                //Colors.grey,
              ),
            ],
            onTap: controller.changeTabIndex),
      );
    });
  }
}
