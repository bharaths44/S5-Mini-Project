import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_flutter/src/customerview/controller/firebase_auth.dart';
import 'package:e_commerce_flutter/src/customerview/controller/firebase_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:e_commerce_flutter/core/app_data.dart';
import 'package:e_commerce_flutter/src/model/product.dart';

import 'package:e_commerce_flutter/src/model/product_category.dart';

class ProductController extends GetxController {
  FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  var userid = FirebaseFunctions().getCurrentUserId();

  List<Product> allProducts = [];
  RxList<Product> filteredProducts = <Product>[].obs;
  RxList<Product> cartProducts = <Product>[].obs;
  RxList<Product> favoriteProducts = <Product>[].obs;
  RxList<ProductCategory> categories = AppData.categories.obs;
  RxInt totalPrice = 0.obs;
  RxString username = ''.obs;
  RxBool isLiked = false.obs;
  RxMap<String, bool> likedProducts = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    getCartItems();
    fetchUsername();
    getFavoriteItems().then((_) => populateLikedProducts());
  }

  Future<void> fetchUsername() async {
    User? user = FirebaseAuth.instance.currentUser;
    username.value = await getUserName(user);
  }

  getAllItems() {
    filteredProducts.assignAll(allProducts);
  }

  Future<void> fetchProducts() async {
    allProducts = await firebaseFunctions.getProducts();
    filteredProducts.value = allProducts;
    await filterItemsByCategory(1);
  }

  Future<void> filterItemsByCategory(int index) async {
    if (allProducts.isEmpty) {
      await fetchProducts();
    }
    for (ProductCategory element in categories) {
      element.isSelected = false;
    }
    categories[index].isSelected = true;

    if (categories[index].type == "all") {
      if (allProducts.isEmpty) {
        await fetchProducts();
      }
      filteredProducts.value = allProducts;
    } else {
      filteredProducts.assignAll(allProducts.where((item) {
        return item.type == categories[index].type;
      }).toList());
    }

    update();
  }

//Favorite Function
  Future<void> isFavorite(int index) async {
    var product = filteredProducts[index];

    var docSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userid).get();

    var favorites = docSnapshot.data()?['favorites'] ?? [];
    var isFavorite = favorites.contains(product.name);

    await FirebaseFirestore.instance.collection('users').doc(userid).update({
      'favorites': isFavorite
          ? FieldValue.arrayRemove([product.name])
          : FieldValue.arrayUnion([product.name]),
    });
    likedProducts[product.id] = !isFavorite;
    getFavoriteItems();
    update();
  }

  Future<void> getFavoriteItems() async {
    var docSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userid).get();
    var favorites = docSnapshot.data()?['favorites'] ?? [];

    favoriteProducts.assignAll(
      allProducts.where((product) {
        return favorites.contains(product.name);
      }).toList(),
    );
    update();
  }

  void populateLikedProducts() {
    // Iterate over all products
    for (var product in allProducts) {
      // Check if the product is in the favoriteProducts list
      if (favoriteProducts
          .any((favoriteProduct) => favoriteProduct.id == product.id)) {
        // If it is, add the product id to the likedProducts map with a value of true
        likedProducts[product.id] = true;
      } else {
        // Otherwise, add the product id with a value of false
        likedProducts[product.id] = false;
      }
    }
    // Update the likedProducts map to trigger updates in the UI
    likedProducts.refresh();
  }

//Cart Function
  void addToCart(Product product) {
    var foundProduct =
        cartProducts.firstWhereOrNull((p) => p.name == product.name);

    if (foundProduct != null) {
      foundProduct.quantity++;
    } else {
      product.quantity = 1;
      cartProducts.add(product);
    }

    FirebaseFirestore.instance.collection('users').doc(userid).update({
      'cart': cartProducts
          .map((product) => {
                'name': product.name,
                'quantity': product.quantity,
                'price': product.price,
                'totalPrice': product.price * product.quantity,
              })
          .toList(),
    });

    calculateTotalPrice();
    update();
  }

  void increaseItemQuantity(Product product) {
    product.quantity++;

    FirebaseFirestore.instance.collection('users').doc(userid).update({
      'cart': cartProducts
          .map((product) => {
                'name': product.name,
                'quantity': product.quantity,
                'price': product.price,
                'totalPrice': product.price * product.quantity,
              })
          .toList(),
    });

    calculateTotalPrice();
    update();
  }

  void decreaseItemQuantity(Product product) {
    product.quantity--;
    if (product.quantity <= 0) {
      cartProducts.remove(product);
    }

    FirebaseFirestore.instance.collection('users').doc(userid).set({
      'cart': cartProducts
          .map((product) => {
                'name': product.name,
                'quantity': product.quantity,
                'price': product.price,
                'totalPrice': product.price * product.quantity,
              })
          .toList(),
    }, SetOptions(merge: true));

    calculateTotalPrice();
    update();
  }

  bool get isEmptyCart => cartProducts.isEmpty;

  void calculateTotalPrice() {
    totalPrice.value = 0;
    for (var element in cartProducts) {
      totalPrice.value += (element.quantity * element.price);
    }
  }

  getCartItems() {
    cartProducts.assignAll(
      allProducts.where((item) => item.quantity > 0),
    );
  }
}