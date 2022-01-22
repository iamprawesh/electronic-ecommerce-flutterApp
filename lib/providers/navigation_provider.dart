import 'package:electronic_ecommerce_flutterapp/models/screen.dart';
import 'package:electronic_ecommerce_flutterapp/views/pages/cart_page.dart';
import 'package:electronic_ecommerce_flutterapp/views/pages/checkout_page.dart';
import 'package:electronic_ecommerce_flutterapp/views/pages/favorite_page.dart';
import 'package:electronic_ecommerce_flutterapp/views/pages/filtered_product.dart';
import 'package:electronic_ecommerce_flutterapp/views/pages/home_page.dart';
import 'package:electronic_ecommerce_flutterapp/views/pages/order_confirm.dart';
import 'package:electronic_ecommerce_flutterapp/views/pages/root.dart';
import 'package:electronic_ecommerce_flutterapp/views/widgets/exit_dialog.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

const HOME_SCREEN = 0;
const CARD_SCREEN = 1;
const FAVORITE_SCREEN = 2;

class NavigationProvider extends ChangeNotifier {
  /// Shortcut method for getting [NavigationProvider].
  static NavigationProvider of(BuildContext context) =>
      Provider.of<NavigationProvider>(context, listen: false);

  int _currentScreenIndex = HOME_SCREEN;

  int get currentTabIndex => _currentScreenIndex;

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print('Generating route: ${settings.name}');
    switch (settings.name) {
      case CheckoutPage.route:
        return MaterialPageRoute(builder: (_) => CheckoutPage());
      case OrderConfirm.route:
        return MaterialPageRoute(builder: (_) => OrderConfirm());
      case FilteredProduct.route:
        return MaterialPageRoute(builder: (_) => FilteredProduct());
      default:
        return MaterialPageRoute(builder: (_) => Root());
    }
  }

  final Map<int, Screen> _screens = {
    HOME_SCREEN: Screen(
      title: 'Home',
      child: HomeScreen(),
      tabIcon: Icons.home_outlined,
      initialRoute: HomeScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case FilteredProduct.route:
            return MaterialPageRoute(builder: (_) => FilteredProduct());
          default:
            return MaterialPageRoute(builder: (_) => HomeScreen());
        }
      },
      scrollController: ScrollController(),
    ),
    CARD_SCREEN: Screen(
      title: 'Cart',
      tabIcon: Icons.shopping_cart_outlined,
      child: CartPage(),
      initialRoute: CartPage.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case CheckoutPage.route:
            return MaterialPageRoute(builder: (_) => CheckoutPage());
          case OrderConfirm.route:
            return MaterialPageRoute(builder: (_) => OrderConfirm());
          default:
            return MaterialPageRoute(builder: (_) => CartPage());
        }
      },
      scrollController: ScrollController(),
    ),
  };

  List<Screen> get screens => _screens.values.toList();

  Screen? get currentScreen => _screens[_currentScreenIndex];

  /// Set currently visible tab.
  void setTab(int tab) {
    if (tab == currentTabIndex) {
      _scrollToStart();
    } else {
      _currentScreenIndex = tab;
      notifyListeners();
    }
  }

  /// If currently displayed screen has given [ScrollController] animate it
  /// to the start of scroll view.
  void _scrollToStart() {
    if (currentScreen!.scrollController!.hasClients) {
      currentScreen?.scrollController!.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Provide this to [WillPopScope] callback.
  Future<bool> onWillPop(BuildContext context) async {
    final currentNavigatorState = currentScreen?.navigatorState?.currentState;

    if (currentNavigatorState!.canPop()) {
      currentNavigatorState.pop();
      return false;
    } else {
      if (currentTabIndex != HOME_SCREEN) {
        setTab(HOME_SCREEN);
        notifyListeners();
        return false;
      } else {
        return await showDialog(
          context: context,
          builder: (context) => ExitAlertDialog(),
        );
      }
    }
  }
}


// Navigator.of(context, rootNavigator: false)
                      // .pushNamed(PushedScreen.route);