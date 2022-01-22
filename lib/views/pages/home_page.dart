import 'package:electronic_ecommerce_flutterapp/consts/app_contants.dart';
import 'package:electronic_ecommerce_flutterapp/models/product.dart';
import 'package:electronic_ecommerce_flutterapp/providers/navigation_provider.dart';
import 'package:electronic_ecommerce_flutterapp/providers/product_provider.dart';
import 'package:electronic_ecommerce_flutterapp/services/db_provider.dart';
import 'package:electronic_ecommerce_flutterapp/views/pages/filtered_product.dart';
import 'package:electronic_ecommerce_flutterapp/views/widgets/custom_button.dart';
import 'package:electronic_ecommerce_flutterapp/views/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const route = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.filter_alt_outlined,
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: false)
                  .pushNamed(FilteredProduct.route);
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // return Future.delayed(Duration(seconds: 4));

          return await productProvider.fetchData();
        },
        child: SingleChildScrollView(
          controller: NavigationProvider.of(context)
              .screens[HOME_SCREEN]
              .scrollController,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       print(productProvider.categories);
              //       productProvider.fetchCart();
              //     },
              //     child: Text("Fetch")),
              // ElevatedButton(
              //     onPressed: () async {
              //       var val = await DatabaseHandler.dropTable("product");
              //       print(val);
              //       print("============================");

              //       // productProvider.removeFromCart(5);
              //     },
              //     child: Text("Drop Table")),
              // ElevatedButton(
              //     onPressed: () async {
              //       var val = await DatabaseHandler.updateQuantity(1, 1);
              //       print(val);
              //       print("============================");

              //       // productProvider.removeFromCart(5);
              //     },
              //     child: Text("Update")),
              Consumer<ProductProvider>(builder: (context, provider, child) {
                return Container(
                  padding: const EdgeInsets.all(AppConstants.SECTION_GAP),
                  child: provider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          physics: const ScrollPhysics(),
                          itemCount: provider.products.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisExtent: 250,
                            mainAxisSpacing: 25,
                          ),
                          itemBuilder: (context, index) {
                            return ProductGridItem(
                                width: width,
                                productItem: provider.products[index]);
                          },
                        ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
