import 'package:e_commerce_flutter/src/adminview/controller/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatelessWidget {
  final AddProductController controller = Get.put(AddProductController());

  AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: controller.name,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: controller.about,
              decoration: InputDecoration(labelText: 'About Product'),
            ),
            TextField(
              controller: controller.price,
              decoration: InputDecoration(labelText: 'Product Price'),
            ),
            TextField(
              controller: controller.stock,
              decoration: InputDecoration(labelText: 'Product Stock'),
            ),
            TextField(
              controller: controller.type,
              decoration: InputDecoration(labelText: 'Product Type'),
            ),
            if (controller.image != null) Image.file(controller.image!),
            ElevatedButton(
              onPressed: controller.uploadImage,
              child: Text('Upload Image'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.addProduct();
              },
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
