import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_flutter/src/model/product.dart';
import 'package:flutter/material.dart' show IconData;

class ProductCategory {
  ProductType type;
  bool isSelected;
  IconData icon;

  ProductCategory(this.type, this.isSelected, this.icon);
  factory ProductCategory.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return ProductCategory(
      ProductType.values
          .firstWhere((e) => e.toString() == 'ProductType.${data?['type']}'),
      data?['isSelected'] as bool,
      IconData(data?['icon'] as int, fontFamily: 'MaterialIcons'),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {"type": type, "isSelected": isSelected, "icon": icon};
  }
}
