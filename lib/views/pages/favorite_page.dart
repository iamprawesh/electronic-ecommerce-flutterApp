import 'package:electronic_ecommerce_flutterapp/models/product.dart';
import 'package:electronic_ecommerce_flutterapp/services/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class FavouritePage extends StatefulWidget {
  FavouritePage({Key? key}) : super(key: key);
  static const route = '/favourite';

  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  void initState() {
    super.initState();

    // this.handler = DatabaseHandler();
    // this.handler.initializeDB().whenComplete(() async {
    //   await this.addProducts();
    //   setState(() {});
    // });
  }

  Future<int> addProducts() async {
    var firstUser = CartProduct(
      id: 1,
      name: "peter",
      price: "111",
      image: "Lebanon",
    );
    var add = await DatabaseHandler();
    add.insertProduct(firstUser);

    return 1;
  }

  Future<void> fetchProducts() async {
    var add = await DatabaseHandler.retrieveProduct();
    print(add[0].name);

    // List<Product> listOfUsers = [firstUser];
    // return await this.handler.insertUser(listOfUsers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite Screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  addProducts();
                },
                child: Text("Hello")),
            ElevatedButton(
                onPressed: () {
                  fetchProducts();
                },
                child: Text("Hello 2")),
          ],
        ),
      ),
    );
  }
}
