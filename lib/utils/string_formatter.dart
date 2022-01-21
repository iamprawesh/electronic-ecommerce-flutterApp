import 'package:flutter/cupertino.dart';

extension StringExtension on String {
  int convertToNumber() {
    final string = this;
    return int.parse(string.replaceAll("\$", ""));
  }
}

extension CustomExcpetion on Widget {
  Widget centerWidget() {
    return Center(
      child: this,
    );
  }
}
