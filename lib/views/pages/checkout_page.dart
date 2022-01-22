import 'package:electronic_ecommerce_flutterapp/consts/app_contants.dart';
import 'package:electronic_ecommerce_flutterapp/providers/product_provider.dart';
import 'package:electronic_ecommerce_flutterapp/views/pages/order_confirm.dart';
import 'package:electronic_ecommerce_flutterapp/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage({Key? key}) : super(key: key);
  static const route = '/cart/checkout';

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  final _fullname = TextEditingController();
  final _emailAddress = TextEditingController();
  final _contact = TextEditingController();
  final _address = TextEditingController();
  final _addressOne = TextEditingController();
  final _addressTwo = TextEditingController();

  @override
  void dispose() {
    _fullname.dispose();
    _emailAddress.dispose();
    _contact.dispose();
    _address.dispose();
    _addressOne.dispose();
    _addressTwo.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(AppConstants.PAGE_PADDING),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "BILLING DETAILS ",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<ProductProvider>(builder: (context, provider, child) {
                  return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Text(
                        "Payable Amount (Cash on Delivery) : \$ ${provider.payableAmount} ",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ));
                }),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "CONTACT DETAILS",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _fullname,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 18),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: new Icon(Icons.person),
                    labelText: "Full Name",
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Field cannot be Empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Field cannot be Empty';
                    }
                    if (value != null) {
                      if (value.length > 5 &&
                          value.contains('@') &&
                          value.endsWith('.com')) {
                        return null;
                      }
                      return 'Enter a Valid Email Address';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 18),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.email),
                    labelText: "Email Address",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _contact,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Field cannot be Empty';
                    }
                    if (value.length < 7 || int.tryParse(value) == null) {
                      return 'Enter Valid Number';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 18),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.phone),
                    labelText: "Contact Number",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "DELIVERY ADDRESS",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _address,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Field cannot be Empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 18),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.location_on),
                    labelText: "Address *",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _addressOne,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 18),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.location_on),
                    labelText: "Address Line 1 (Optional)",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _addressTwo,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 18),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.location_on),
                    labelText: "Address Line 2 (Optional)",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButtom(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(OrderConfirm.route);
                      }
                    },
                    text: "Confirm  Order",
                    width: double.infinity)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
