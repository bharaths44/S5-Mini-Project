import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_commerce_flutter/src/model/product.dart';
import 'package:e_commerce_flutter/src/model/product_category.dart';
import 'package:e_commerce_flutter/src/model/product_size_type.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

String dbRef1 = 'product';
String dbRef2 = 'product_category';
String dbRef3 = 'product_size_type';

Future<List<ProductCategory>> getProductCategories() async {
  List<ProductCategory> categories = [];

  await db.collection(dbRef2).get().then((snapshot) {
    for (var doc in snapshot.docs) {
      categories.add(ProductCategory.fromFirestore(doc));
    }
  });

  return categories;
}

Future<List<ProductSizeType>> getProductSizeTypes() async {
  List<ProductSizeType> sizeTypes = [];

  await db.collection(dbRef3).get().then((snapshot) {
    for (var doc in snapshot.docs) {
      sizeTypes.add(ProductSizeType.fromFirestore(doc));
    }
  });

  return sizeTypes;
}

Future<List<Product>> getProducts() async {
  List<Product> products = [];
  await db.collection(dbRef1).get().then((snapshot) {
    for (var doc in snapshot.docs) {
      products.add(Product.fromFirestore(doc));
    }
  });

  return products;
}
