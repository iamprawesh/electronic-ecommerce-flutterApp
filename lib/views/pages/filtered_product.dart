import 'dart:math';

import 'package:electronic_ecommerce_flutterapp/consts/app_contants.dart';
import 'package:electronic_ecommerce_flutterapp/providers/product_provider.dart';
import 'package:electronic_ecommerce_flutterapp/views/pages/home_page.dart';
import 'package:electronic_ecommerce_flutterapp/views/widgets/custom_button.dart';
import 'package:electronic_ecommerce_flutterapp/views/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:electronic_ecommerce_flutterapp/utils/string_formatter.dart';

class FilteredProduct extends StatefulWidget {
  FilteredProduct({Key? key}) : super(key: key);
  static const route = '/home/filter';

  @override
  _FilteredProductState createState() => _FilteredProductState();
}

class _FilteredProductState extends State<FilteredProduct> {
  RangeValues _currentRangeValues = RangeValues(0, 15000);
  List products = [];
  final ScrollController _controller = ScrollController();

// This is what you're looking for!
  void _scrollDown() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return filterSheet(context);
          });
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      var price = productProvider.priceRange;
      // setState(() {
      //   _currentRangeValues =
      //       RangeValues(price.first.toDouble(), price.last.toDouble());
      // });
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
        title: const Text("Filtered Product"),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              productProvider.resetFilter();

              Navigator.pop(context, true);
            }),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.filter_alt_outlined,
            ),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return filterSheet(context);
                  }).whenComplete(() {
                // var price = productProvider.priceRange;
                // productProvider.resetFilter();
                _currentRangeValues = RangeValues(0, 15000);
                // _currentRangeValues =
                //     RangeValues(price.first.toDouble(), price.last.toDouble());
                // _currentRangeValues = const RangeValues(0, 100);
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Consumer<ProductProvider>(builder: (context, provider, child) {
          List filteredProducts = [];
          if (provider.applyFilter) {
            provider.products.forEach((productItem) {
              // looping through each product
              var priceFilter = (productItem.price.convertToNumber() >
                      provider.priceRange.first &&
                  productItem.price.convertToNumber() <
                      provider.priceRange.last);
              if (priceFilter) {
                // filtering by price
                if (provider.filterCategory.length == 0) {
                  return filteredProducts.add(productItem);
                }
                productItem.category.forEach((e) {
                  // looping through each category
                  var val = provider.filterCategory.contains(e);
                  // filtering by category
                  if (val) {
                    filteredProducts.add(productItem);
                  }
                });
              }
            });
          }
          return Container(
            padding: const EdgeInsets.all(AppConstants.SECTION_GAP),
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredProducts.length == 0 && provider.applyFilter
                    ? Text(
                        "No Product Found",
                        style: Theme.of(context).textTheme.headline3,
                      ).centerWidget()
                    : GridView.builder(
                        physics: const ScrollPhysics(),
                        itemCount: filteredProducts.length,
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
                              productItem: filteredProducts[index]);
                        },
                      ),
          );
        }),
      ),
    );
  }

  Container filterSheet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return Container(
      height: 330,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          return Wrap(
            children: [
              Text(
                "Price",
                style: Theme.of(context).textTheme.headline2,
              ),
              RangeSlider(
                  values: _currentRangeValues,
                  min: 0,
                  max: 15000,
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                  }),

              Text(
                "\$ ${_currentRangeValues.start.round().toString()} - ${_currentRangeValues.end.round().toString()} ",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  height: 2,
                  color: Colors.black38,
                ),
              ),
              Text(
                "Category",
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                height: 5,
              ),
              Consumer<ProductProvider>(builder: (context, provider, child) {
                return provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        primary: false,
                        itemCount: provider.categories.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: (2.5 / 1),
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          // print(provider.categories[index].category.contains(provider.filterCategory));
                          return FilterChipWidget(
                            chipName: provider.categories[index],

                            // chipName: provider.categories.keys.elementAt(index),
                          );
                        },
                      );
              }),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  height: 2,
                  color: Colors.black38,
                ),
              ),
              CustomButtom(
                onPressed: () {
                  Navigator.pop(context);
                  // productProvider.filterProduct();
                  // Navigator.pushNamed(context,rootNavigator: false, FilteredProduct.route);
                  // Navigator.of(context, rootNavigator: false)
                  //     .pushNamed(FilteredProduct.route);

                  productProvider.filterProduct(_currentRangeValues);
                  _scrollDown();
                  // productProvider.filterPriceRange = []
                },
                text: "Apply Filters",
                width: width * .7,
              ),
              const SizedBox(
                height: 30,
              ),
              // other stuff
            ],
          );
        },
      ),
    );
  }
}

class FilterChipWidget extends StatefulWidget {
  final String? chipName;
  FilterChipWidget({Key? key, @required this.chipName}) : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 20,
        child: Consumer<ProductProvider>(
          builder: (context, provider, child) => FilterChip(
            label: Text(widget.chipName ?? ""),
            selected: provider.filterCategory.contains(widget.chipName)
                ? true
                : _isSelected,
            onSelected: (bool value) {
              setState(() {
                _isSelected = value;
                provider.addCategory(widget.chipName, value);
              });
            },
          ),
        ));
  }
}
