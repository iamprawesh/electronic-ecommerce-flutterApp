import 'package:electronic_ecommerce_flutterapp/consts/app_contants.dart';
import 'package:electronic_ecommerce_flutterapp/models/product.dart';
import 'package:electronic_ecommerce_flutterapp/providers/product_provider.dart';
import 'package:electronic_ecommerce_flutterapp/utils/colors.dart';
import 'package:electronic_ecommerce_flutterapp/utils/string_formatter.dart';
import 'package:electronic_ecommerce_flutterapp/views/pages/checkout_page.dart';

import 'package:electronic_ecommerce_flutterapp/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);
  static const route = '/cart';

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
              right: AppConstants.PAGE_PADDING,
              left: AppConstants.PAGE_PADDING),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<ProductProvider>(builder: (context, provider, child) {
                return Container(
                  // padding: const EdgeInsets.all(AppConstants.SECTION_GAP),
                  child: provider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : provider.myCart.length == 0
                          ? Container(
                              padding: EdgeInsets.only(top: 100),
                              height: height * .7,
                              child: Column(
                                children: [
                                  const Text(
                                    "Cart is empty !",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 40, color: Colors.grey),
                                  ).centerWidget(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 300,
                                    child: const Text(
                                      "Looks like you have no items on your shopping cart",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ).centerWidget(),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              height: height * .7,
                              child: ListView.builder(
                                physics: const ScrollPhysics(),
                                itemCount: provider.myCart.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return CartItem(
                                    provider: provider,
                                    productItem: provider.myCart[index],
                                  );
                                },
                              ),
                            ),
                );
              }),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Consumer<ProductProvider>(
                        builder: (context, provider, child) {
                      var total = 0;
                      provider.myCart.forEach((e) {
                        var q = e.quantity ?? 1;
                        total += e.price!.convertToNumber() * q;
                      });
                      print(provider.myCart);
                      print("provider.myCart");

                      return Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "TOTAL",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\$ ${total}',
                                  style: const TextStyle(
                                    fontSize: 25,
                                    // color: Colors.black38,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: CustomButtom(
                                disable:
                                    provider.myCart.length == 0 ? true : false,
                                onPressed: () {
                                  provider.totalAmount(total);
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed(CheckoutPage.route);
                                },
                                text: "Checkout",
                                width: width * .6),
                          ),
                        ],
                      );
                    })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatefulWidget {
  final CartProduct productItem;
  final ProductProvider provider;

  const CartItem({
    Key? key,
    required this.productItem,
    required this.provider,
  }) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 1;
  @override
  void initState() {
    // TODO: implement initState
    quantity = widget.productItem.quantity ?? 1;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                      'https://electronic-ecommerce.herokuapp.com/${widget.productItem.image}')),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.productItem.name ?? "",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      InkWell(
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Icon(
                            Icons.delete,
                            size: 20,
                            color: DANGER,
                          ),
                        ),
                        onTap: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            duration:
                                Duration(milliseconds: 1000), // default 2s

                            content: Text("Removed From Cart"),
                          ));
                          widget.provider
                              .removeFromCart(widget.productItem.id ?? 0);
                          print("Remove From cart");
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    widget.productItem.price ?? "",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Icon(
                                Icons.add,
                                size: 22,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                quantity += 1;
                                widget.provider.updateCartQuantity(
                                    widget.productItem.id ?? 0, quantity);
                              });
                              print("Add");
                            },
                          ),
                          Container(
                            width: 25.0,
                            height: 25,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Colors.blueGrey,
                            )),
                            child: Text(
                              quantity.toString(),
                              style: const TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                            ).centerWidget(),
                          ),
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Icon(
                                Icons.remove,
                                size: 22,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                if (quantity == 1) {
                                } else {
                                  quantity -= 1;
                                  widget.provider.updateCartQuantity(
                                      widget.productItem.id ?? 0, quantity);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Theme.of(context).primaryColor,
                          ),
                          padding: const EdgeInsets.all(7),
                          child: const Text(
                            "Stock : 8",
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
