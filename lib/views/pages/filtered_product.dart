import 'package:electronic_ecommerce_flutterapp/consts/app_contants.dart';
import 'package:electronic_ecommerce_flutterapp/providers/product_provider.dart';
import 'package:electronic_ecommerce_flutterapp/views/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilteredProduct extends StatefulWidget {
  FilteredProduct({Key? key}) : super(key: key);

  @override
  _FilteredProductState createState() => _FilteredProductState();
}

class _FilteredProductState extends State<FilteredProduct> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Electronic Ecommerce"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.filter_alt_outlined,
            ),
            onPressed: () {
              // showModalBottomSheet(
              //     context: context,
              //     isScrollControlled: true,
              //     backgroundColor: Colors.transparent,
              //     builder: (context) {
              //       return filterSheet(context);
              //     }).whenComplete(() {
              //   _currentRangeValues = const RangeValues(0, 100);
              // });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                          // childAspectRatio: (itemWidth / itemHeight),
                          crossAxisSpacing: 10.0,
                          mainAxisExtent: 250,
                          mainAxisSpacing: 25,
                          // maxCrossAxisExtent: 500,
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
    );
  }
}
