import 'package:electronic_ecommerce_flutterapp/models/product.dart';
import 'package:electronic_ecommerce_flutterapp/providers/product_provider.dart';
import 'package:electronic_ecommerce_flutterapp/views/pages/cart_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({
    Key? key,
    required this.width,
    required this.productItem,
  }) : super(key: key);

  final double width;
  final Product productItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // color: Color(0xFF000000),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(.8), BlendMode.dstATop),
                        image: NetworkImage(
                            'https://electronic-ecommerce.herokuapp.com/${productItem.image}')),
                  ),
                ),
              ),
              const Positioned(
                top: -3,
                right: -5.0,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.favorite_border,
                    // color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productItem.name,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "Category : ${productItem.category.toString().substring(1, productItem.category.toString().length - 1)}",
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(productItem.price,
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        )),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Theme.of(context).primaryColor,
                        ),
                        padding: const EdgeInsets.all(7),
                        child: Text(
                          "Stock : ${productItem.stock}",
                          style: const TextStyle(
                            fontSize: 13.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          Consumer<ProductProvider>(builder: (context, provider, child) {
            var alreadyInCart = false;
            // if (provider.myCart.length != 0) {
            //   provider.myCart.forEach(
            //       (e) => {if (e.id == productItem.id) alreadyInCart = true});
            // }
            provider.myCart.forEach(
                (e) => {if (e.id == productItem.id) alreadyInCart = true});

            return InkWell(
              onTap: () {
                print("ASdas");

                if (alreadyInCart) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Already in Cart"),
                  ));
                } else {
                  provider.addToCart(productItem);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Added to Cart"),
                  ));
                }
                print(alreadyInCart);
                print("alreadyInCart");
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                width: width,
                child: Center(
                    child: Text(
                  alreadyInCart ? "Already in Cart" : "Add to Cart",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                )),
              ),
            );
          })
        ],
      ),
    );
  }
}
