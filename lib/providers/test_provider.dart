// https://electronic-ecommerce.herokuapp.com/api/v1/product\

import 'package:flutter/foundation.dart';

class AppState with ChangeNotifier {
  AppState();
  String _displayText = "";
  void setDisplayText(String text) {
    _displayText = text;
    notifyListeners();
  }

  String get getDisplayText => _displayText;
}
