import 'package:electronic_ecommerce_flutterapp/consts/app_contants.dart';
import 'package:electronic_ecommerce_flutterapp/models/product.dart';
import 'package:electronic_ecommerce_flutterapp/providers/navigation_provider.dart';
import 'package:electronic_ecommerce_flutterapp/providers/product_provider.dart';
import 'package:electronic_ecommerce_flutterapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const route = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> images = [
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png"
  ];
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchData();
      // Add Your Code here.
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    List<String>.generate(10000, (i) => 'Item $i');

    /*24 is for notification bar on Android*/
    // final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemHeight = 300;

    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Electronic Ecommerce"),
      ),
      body: SingleChildScrollView(
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
      // color: Colors.white,
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
                  style: TextStyle(
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
                  style: TextStyle(
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
                        style: TextStyle(
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
                          style: TextStyle(
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
            padding: EdgeInsets.symmetric(vertical: 10),
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
