import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_flutter/src/model/product_size_type.dart';

enum ProductType { all, watch, mobile, headphone, tablet, tv }

class Product {
  String name;
  int price;
  int? off;
  String about;
  bool isAvailable;
  ProductSizeType? sizes;
  int _quantity;
  List<String> images;
  bool isFavorite;
  double rating;
  ProductType type;

  int get quantity => _quantity;

  set quantity(int newQuantity) {
    if (newQuantity >= 0) _quantity = newQuantity;
  }

  Product({
    required this.name,
    required this.price,
    required this.about,
    required this.isAvailable,
    this.sizes,
    required this.off,
    required int quantity,
    required this.images,
    required this.isFavorite,
    required this.rating,
    required this.type,
  }) : _quantity = quantity;

  factory Product.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
   // SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Product(
      name: data?['name'],
      price: data?['price'],
      off: data?['off'],
      about: data?['about'],
      isAvailable: data?['isAvailable'],
      sizes: data?['sizes'],
      images: data?['images'],
      quantity: data?['quantity'],
      isFavorite: data?['isFavorite'],
      rating: data?['rating'],
      type: data?['type'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "price": price,
      if (off != null) "off": off,
      "about": about,
      "isAvailable": isAvailable,
      if (sizes != null) "sizes": sizes,
      "images": images,
      "quantity": quantity,
      "isFavorite": isFavorite,
      "rating": rating,
      "type": type,
    };
  }

  
}
