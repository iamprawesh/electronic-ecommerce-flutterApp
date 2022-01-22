import 'package:electronic_ecommerce_flutterapp/utils/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final myTheme = ThemeData(
    scaffoldBackgroundColor: LIGHT,
    primaryColor: const Color(0xFF4F9AE6),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF4F9AE6),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: LIGHT,
      iconTheme: IconThemeData(color: Colors.black),
      actionsIconTheme: IconThemeData(color: Colors.black),
      centerTitle: true,
      elevation: 1,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
          fontSize: 19.0, fontWeight: FontWeight.bold, color: Colors.black),
      headline3: TextStyle(
        fontSize: 17.0,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      headline4: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
