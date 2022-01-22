import 'package:electronic_ecommerce_flutterapp/consts/app_contants.dart';

import 'package:flutter/material.dart';
import 'package:electronic_ecommerce_flutterapp/utils/string_formatter.dart';

class OrderConfirm extends StatefulWidget {
  OrderConfirm({Key? key}) : super(key: key);
  static const route = '/cart/confirm';

  @override
  _OrderConfirmState createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: The,
      backgroundColor: Theme.of(context).primaryColor,

      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(AppConstants.PAGE_PADDING),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 150),
                  // height: height * .7,
                  child: Column(
                    children: [
                      const Text(
                        "Order Placed !",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 45, color: Colors.white),
                      ).centerWidget(),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 300,
                        child: const Text(
                          "Your Order was placed successfully.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ).centerWidget(),
                      ),
                      const Icon(
                        Icons.file_download_done_rounded,
                        color: Colors.white,
                        size: 100,
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
