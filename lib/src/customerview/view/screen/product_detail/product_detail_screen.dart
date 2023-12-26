import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/src/model/product.dart';
import 'package:e_commerce_flutter/src/customerview/controller/product_controller.dart';

final ProductController controller = Get.put(ProductController());

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen(this.product, {Key? key}) : super(key: key);

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Colors.black),
      ),
    );
  }

  Widget productPageView(double width, double height) {
    return Container(
      height: height * 0.42,
      width: width,
      decoration: const BoxDecoration(
        color: Color(0xFFE5E6E8),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(200),
          bottomLeft: Radius.circular(200),
        ),
      ),
      child: Image(
          image: NetworkImage(
        product.image,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _appBar(context),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productPageView(width, height),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 10),
                      // _ratingBar(context),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "₹${product.price}",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          const SizedBox(width: 3),
                          const Spacer(),
                          Text(
                            product.isAvailable
                                ? "Available in stock"
                                : "Not available",
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "About",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 10),
                      Text(product.about),
                      const SizedBox(height: 20),

                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: product.isAvailable
                              ? () => controller.addToCart(product)
                              : null,
                          child: const Text("Add to cart"),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
