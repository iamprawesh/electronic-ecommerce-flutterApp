import 'package:electronic_ecommerce_flutterapp/consts/app_contants.dart';
import 'package:electronic_ecommerce_flutterapp/models/product.dart';
import 'package:electronic_ecommerce_flutterapp/services/api_service.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  bool _isLoading = false;

  List<Product> _items = [];
  List _categories = [];
  List _priceRange = [];

  bool get isLoading => _isLoading;
  List<Product> get products => _items;
  List get categories => _categories;

  Future<void> fetchData() async {
    try {
      _isLoading = true;
      notifyListeners();

      var response = await APIManager().GetAPICall(AppConstants.API_URL);
      if (response != null) {
        var products = ProductResponse.fromJson(response).data.product;
        _items = products;
      }
      assignCategories(products);
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

  Future<void> filterProduct() async {
    print("hello world");

    _items = [];
    print(_items);
    notifyListeners();
  }
}
