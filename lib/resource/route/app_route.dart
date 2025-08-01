import 'package:get/get.dart';
import 'package:practice/resource/route/route_name.dart';
import 'package:practice/view/cart/cart_screen.dart';
import 'package:practice/view/home/products_screen.dart';
import 'package:practice/view/splash_screen.dart';

class AppRoute {
  static appRoutes() => [
    GetPage(
      name: RouteName.splashScreen,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RouteName.productsScreen,
      transition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 500),
      page: () => const ProductsScreen(),
    ),
    GetPage(
      name: RouteName.cartScreen,
      transition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 500),
      page: () => CartScreen(),
    ),
  ];
}
