import 'package:electronic_ecommerce_flutterapp/providers/navigation_provider.dart';
import 'package:electronic_ecommerce_flutterapp/providers/product_provider.dart';
import 'package:electronic_ecommerce_flutterapp/providers/test_provider.dart';
import 'package:electronic_ecommerce_flutterapp/utils/app_route.dart';
import 'package:electronic_ecommerce_flutterapp/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NavigationProvider()),
          ChangeNotifierProvider(create: (_) => AppState()),
          ChangeNotifierProvider(create: (_) => ProductProvider()),
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp(
              theme: AppTheme.myTheme,
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              onGenerateRoute: NavigationProvider.of(context).onGenerateRoute,
            );
          },
        ));
  }
}
