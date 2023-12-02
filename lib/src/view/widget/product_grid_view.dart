import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/src/model/product.dart';
import 'package:e_commerce_flutter/src/view/animation/open_container_wrapper.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    Key? key,
    required this.items,
    
    required this.likeButtonPressed,
  }) : super(key: key);

  final List<Product> items;

  final void Function(int index) likeButtonPressed;

  //   return Padding(
  //     padding: const EdgeInsets.all(10.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Visibility(
  //           // visible: isPriceOff(product),
  //           child: Container(
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(30),
  //               color: Colors.white,
  //             ),
  //             width: 80,
  //             height: 30,
  //             alignment: Alignment.center,
  //             child: const Text(
  //               "30% OFF",
  //               style: TextStyle(fontWeight: FontWeight.w600),
  //             ),
  //           ),
  //         ),
  //         IconButton(
  //           icon: Icon(
  //             Icons.favorite,
  //             color: items[index].isFavorite
  //                 ? Colors.redAccent
  //                 : const Color(0xFFA6A3A0),
  //           ),
  //           onPressed: () => likeButtonPressed(index),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _gridItemBody(Product product) {
    return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFFE5E6E8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image(
          image: NetworkImage(product.image,
              headers: {'Cache-Control': 'no-cache'}),
        ));
  }

  Widget _gridItemFooter(Product product, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        //height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Text(
                product.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            // const SizedBox(height: 5),
            Row(
              children: [
                Text("\$${product.price}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    )),
                // const SizedBox(width: 3),
                // Visibility(
                //   //  visible: product.off != null ? true : false,
                //   child: Text(
                //     "\$${product.price}",
                //     style: const TextStyle(
                //       decoration: TextDecoration.lineThrough,
                //       color: Colors.grey,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GridView.builder(
        itemCount: items.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 10 / 16,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (_, index) {
          Product product = items[index];
          return OpenContainerWrapper(
            product: product,
            child: GridTile(
              //header: _gridItemHeader(product, index),
              footer: _gridItemFooter(product, context),
              child: _gridItemBody(product),
            ),
          );
        },
      ),
    );
  }
}
