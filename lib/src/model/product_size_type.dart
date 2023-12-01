import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_flutter/src/model/categorical.dart';
import 'package:e_commerce_flutter/src/model/numerical.dart';

class ProductSizeType {
  List<Numerical>? numerical;
  List<Categorical>? categorical;

  ProductSizeType({this.numerical, this.categorical});

  factory ProductSizeType.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return ProductSizeType(
      numerical: data?['name'],
      categorical: data?['price'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (numerical != null) "numerical": numerical,
      if (categorical != null) "categorical": categorical,
    };
  }
}
