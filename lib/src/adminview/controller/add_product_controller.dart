import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProductController extends GetxController {
  TextEditingController about = TextEditingController();
  //TextEditingController image = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController type = TextEditingController();

   Future<void> uploadImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File file = File(image.path);
      try {
        // Upload to Firebase Storage
        TaskSnapshot taskSnapshot = await FirebaseStorage.instance
            .ref('uploads/${DateTime.now().toIso8601String()}')
            .putFile(file);
        final String downloadURL = await taskSnapshot.ref.getDownloadURL();
        FirebaseFirestore.instance.collection('products').add({
          'image': downloadURL,
          
        });
      } on FirebaseException catch (e) {
        // Handle error
        print(e);
      }
    }
  }
}
