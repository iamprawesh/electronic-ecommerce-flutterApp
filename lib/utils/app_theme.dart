import 'package:electronic_ecommerce_flutterapp/utils/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final myTheme = ThemeData(
    scaffoldBackgroundColor: LIGHT,
    primaryColor: Color(0xFF4F9AE6),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blueAccent,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: LIGHT,
      iconTheme: IconThemeData(color: Colors.black),
      actionsIconTheme: IconThemeData(color: Colors.black),
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 20.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        fontSize: 19.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
      bodyText1: TextStyle(
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
