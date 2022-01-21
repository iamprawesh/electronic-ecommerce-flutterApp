import 'package:electronic_ecommerce_flutterapp/consts/app_contants.dart';
import 'package:electronic_ecommerce_flutterapp/models/product.dart';
import 'package:electronic_ecommerce_flutterapp/services/api_service.dart';
import 'package:electronic_ecommerce_flutterapp/services/db_provider.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _applyFilter = false;

  List<Product> _items = [];
  List<Product> get products => _items;

// for displayiing items in cart
  List<CartProduct> _cart = [];
  List<CartProduct> get myCart => _cart;

  // for displaying items in favourite
  List<Product> _favourite = [];
  List<Product> get myFavourite => _favourite;

// for filtering products
  List _categories = [];
  List _priceRange = [];
  List filterCategory = [];

  bool get isLoading => _isLoading;
  bool get applyFilter => _applyFilter;

  List get categories => _categories;
  List get priceRange => _priceRange;

  Future<void> initilizeLocalDb() async {
    DatabaseHandler.initDb().whenComplete(() {
      DatabaseHandler.createTable();
      fetchCart();
    });
  }

  Future<void> fetchData() async {
    initilizeLocalDb();
    try {
      _isLoading = true;
      notifyListeners();

      var response = await APIManager().GetAPICall(AppConstants.API_URL);
      if (response != null) {
        var products = ProductResponse.fromJson(response).data.product;
        _items = products;
      }
      assignCategories(products);
      ;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> assignCategories(List products) async {
    var temp = [];
    var prices = [];
    products.forEach((item) {
      prices.add(int.parse(item.price.toString().replaceAll("\$", "")));
      temp.addAll(item.category);
    });
    // sorting the price and getting the max and min price range
    prices.sort();
    _priceRange = [prices.first, prices.last];

    // removing all duplicacy in the list temp
    final uniqueStrings = temp.toSet().toList();
    _categories = uniqueStrings;
  }

// filter category

  Future<void> filterProduct(RangeValues priceRange) async {
    _priceRange = [priceRange.start, priceRange.end];
    _applyFilter = true;

    notifyListeners();
  }

  Future<void> addCategory(String? cat, bool value) async {
    if (value) {
      filterCategory.add(cat);
    } else {
      filterCategory.remove(cat);
    }
  }

  Future<void> resetFilter() async {
    filterCategory = [];
    _applyFilter = false;
    notifyListeners();
  }

  // add to cart,fetch cart from local
  Future<void> fetchCart() async {
    var carts = await DatabaseHandler.retrieveProduct();
    print("==============");
    _cart = carts;
    print(_cart.length);
    notifyListeners();

    print(_cart);
  }

  Future<void> addToCart(Product product) async {
    var carts = await DatabaseHandler();
    carts.insertProduct(CartProduct(
        id: product.id,
        name: product.name,
        price: product.price,
        image: product.image));
    // _cart = carts;
    fetchCart();
  }

  Future<void> removeFromCart(int id) async {
    var carts = await DatabaseHandler.deleteProduct(id);
    // _cart = carts;
    fetchCart();
    notifyListeners();
  }
}
