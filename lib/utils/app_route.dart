// import 'package:electronic_ecommerce_flutterapp/views/pages/cart_page.dart';
// import 'package:electronic_ecommerce_flutterapp/views/pages/home_page.dart';
// import 'package:electronic_ecommerce_flutterapp/views/tab/tab_naviagtion.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class RouteGenerator {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/':
//         return MaterialPageRoute(builder: (_) => MyBottomTabNaviagtion());
//       case 'home':
//         return MaterialPageRoute(builder: (_) => HomeScreen());
//       case '/cart':
//         return MaterialPageRoute(builder: (_) => CardPage());
//       default:
//         return _errorRoute();
//     }
//   }

//   static Route<dynamic> _errorRoute() {
//     return MaterialPageRoute(builder: (_) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Error'),
//         ),
//         body: Center(
//           child: Text('ERROR'),
//         ),
//       );
//     });
//   }
// }
