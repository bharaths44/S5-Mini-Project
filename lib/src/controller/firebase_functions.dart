import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_commerce_flutter/src/model/product.dart';
import 'package:e_commerce_flutter/src/model/product_category.dart';
import 'package:e_commerce_flutter/src/model/product_size_type.dart';

class FirebaseFunctions {
  String dbRef1 = 'product';
  String dbRef2 = 'product_category';
  String dbRef3 = 'product_size_type';
  List<ProductCategory> categories = [];
  List<ProductSizeType> sizeTypes = [];
  List<Product> products = [];
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Future<List<ProductCategory>> getProductCategories() async {
  //   await db.collection(dbRef2).get().then((snapshot) {
  //     for (var doc in snapshot.docs) {
  //       categories.add(ProductCategory.fromFirestore(doc));
  //     }
  //   });

  //   return categories;
  // }

  Future<List<ProductSizeType>> getProductSizeTypes() async {
    await db.collection(dbRef3).get().then((snapshot) {
      for (var doc in snapshot.docs) {
        sizeTypes.add(ProductSizeType.fromFirestore(doc));
      }
    });

    return sizeTypes;
  }

  Future<List<Product>> getProducts() async {
    try {
      print("In getProducts");
      await db.collection(dbRef1).get().then((snapshot) {
        for (var doc in snapshot.docs) {
          products.add(Product.fromFirestore(doc));
        }
      });
      print(products);
    } catch (e) {
      print('Error getting products: $e');
    }
    return products;
  }

  Future<void> addProduct() async {
    String productName = "iphone 13";
    await db.collection(dbRef1).doc(productName).set({
      // 'id': product.id,
      'name': "iphone 13",
      'about':
          "Experience the pinnacle of innovation with the iPhone 13. Its advanced A15 Bionic chip, stunning Super Retina XDR display, and professional-grade camera system redefine smartphone technology. From capturing life's moments to seamless performance, the iPhone 13 delivers excellence in every touch",
      'price': 90000,
      'isAvailable': true,
      'image': "https://www.dslr-zone.com/wp-content/uploads/2021/10/5-2.jpeg",
      '_quantity': 1,
      'isFavorite': false,
      'type': "mobile",
      'stock': 10,
    });
  }
}
