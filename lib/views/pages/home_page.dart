import 'package:electronic_ecommerce_flutterapp/consts/app_contants.dart';
import 'package:electronic_ecommerce_flutterapp/models/product.dart';
import 'package:electronic_ecommerce_flutterapp/providers/navigation_provider.dart';
import 'package:electronic_ecommerce_flutterapp/providers/product_provider.dart';
import 'package:electronic_ecommerce_flutterapp/views/widgets/custom_button.dart';
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

  RangeValues _currentRangeValues = const RangeValues(0, 100);

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
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return filterSheet(context);
                  }).whenComplete(() {
                _currentRangeValues = const RangeValues(0, 100);
              });
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
                max: 100,
                divisions: 10,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  print(values);
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),
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
                          return FilterChipWidget(
                            chipName: provider.categories[index],
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
                  productProvider.filterProduct();
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
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Theme.of(context).primaryColor,
            ),
            width: width,
            child: const Center(
                child: Text(
              "Add to Cart",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            )),
          )
        ],
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
      child: FilterChip(
        label: Text(widget.chipName ?? ""),
        selected: _isSelected,
        onSelected: (bool value) {
          setState(() {
            _isSelected = !_isSelected;
          });
        },
      ),
    );
  }
}
