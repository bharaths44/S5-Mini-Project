import 'package:cloud_firestore/cloud_firestore.dart';

//enum ProductType { all, watch, mobile, headphone, tablet, tv }

class Product {
  String name;
  int price;
  // int? off;
  String about;
  bool isAvailable;
  //ProductSizeType? sizes;
  int quantity;
  String image;
  bool isFavorite;
  //double rating;
  String type;
  int stock;

  Product({
    required this.stock,
    required this.name,
    required this.price,
    required this.about,
    required this.isAvailable,
    // this.sizes,
    // required this.off,
    required this.quantity,
    required this.image,
    required this.isFavorite,
    //required this.rating,
    required this.type,
  });
  factory Product.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      name: data['name'],
      price: data['price'] ?? 0,
      about: data['about'],
      isAvailable: data['isAvailable'] ?? false,
      quantity: data['quantity'] ?? 0,
      image: data['image'],
      isFavorite: data['isFavorite'] ?? false,
      type: data['type'],
      stock: data['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "price": price,
      // if (off != null) "off": off,
      "about": about,
      "isAvailable": isAvailable,
      //  if (sizes != null) "sizes": sizes,
      "image": image,
      "quantity": quantity,
      "isFavorite": isFavorite,
      //"rating": rating,
      "type": type,
      "stock": stock,
    };
  }
}
