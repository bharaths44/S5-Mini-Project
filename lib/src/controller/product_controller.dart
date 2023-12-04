import 'package:e_commerce_flutter/src/controller/firebase_functions.dart';
import 'package:get/get.dart';

import 'package:e_commerce_flutter/core/app_data.dart';
import 'package:e_commerce_flutter/src/model/product.dart';

import 'package:e_commerce_flutter/src/model/product_category.dart';

class ProductController extends GetxController {
  FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  List<Product> allProducts = [];
  RxList<Product> filteredProducts = <Product>[].obs;
  RxList<Product> cartProducts = <Product>[].obs;
  RxList<ProductCategory> categories = AppData.categories.obs;
  RxInt totalPrice = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    // FirebaseFunctions().addProduct();
    print("fetching");
  }

  Future<void> fetchProducts() async {
    allProducts = await firebaseFunctions.getProducts();
    filteredProducts.value = allProducts;
    print(allProducts.length);
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
      print(filteredProducts.length);
    } else {
      filteredProducts.assignAll(allProducts.where((item) {
        return item.type == categories[index].type;
      }).toList());
    }

    update();
  }

  void isFavorite(int index) {
    filteredProducts[index].isFavorite = !filteredProducts[index].isFavorite;
    update();
  }

  void addToCart(Product product) {
    var foundProduct =
        cartProducts.firstWhereOrNull((p) => p.name == product.name);

    if (foundProduct != null) {
      foundProduct.quantity++;
    } else {
      product.quantity = 1;
      cartProducts.add(product);
    }

    print("In add to cart");
    print(cartProducts.length);
    calculateTotalPrice();
    print('Price $totalPrice');
    update();
  }

  void increaseItemQuantity(Product product) {
    product.quantity++;
    calculateTotalPrice();
    update();
  }

  void decreaseItemQuantity(Product product) {
    product.quantity--;
    calculateTotalPrice();
    update();
  }

  bool get isEmptyCart => cartProducts.isEmpty;

  void calculateTotalPrice() {
    totalPrice.value = 0;
    for (var element in cartProducts) {
      totalPrice.value += element.quantity * element.price;
    }
  }

  getFavoriteItems() {
    filteredProducts.assignAll(
      allProducts.where((item) => item.isFavorite),
    );
  }

  getCartItems() {
    cartProducts.assignAll(
      allProducts.where((item) => item.quantity > 0),
    );
  }

  getAllItems() {
    filteredProducts.assignAll(allProducts);
  }
}
