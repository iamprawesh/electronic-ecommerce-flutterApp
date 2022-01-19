import 'package:electronic_ecommerce_flutterapp/consts/app_contants.dart';
import 'package:electronic_ecommerce_flutterapp/models/product.dart';
import 'package:electronic_ecommerce_flutterapp/services/api_service.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  bool _isLoading = false;

  final List<Product> _items = [];

  bool get isLoading => _isLoading;
  List<Product> get products => _items;

  Future<void> fetchData() async {
    try {
      _isLoading = true;
      notifyListeners();

      var response = await APIManager().GetAPICall(AppConstants.API_URL);
      if (response != null) {
        var products = ProductResponse.fromJson(response).data.product;
        _items.addAll(products);
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
