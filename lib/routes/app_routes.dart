import 'package:e_commerce_app/core/constants/routes.dart';
import 'package:e_commerce_app/features/cart/presentation/pages/cart_page.dart';
import 'package:e_commerce_app/features/login/presentation/pages/login.dart';
import 'package:e_commerce_app/features/product/presentation/pages/product_page.dart';
import 'package:e_commerce_app/shared/widgets/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: RoutesName.defaultPath,
  navigatorKey: navigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: RoutesName.defaultPath,
      builder: (BuildContext context, GoRouterState state) {
        return AuthPage();
      },
    ),
    GoRoute(
      path: RoutesName.loginPath,
      builder: (BuildContext context, GoRouterState state) {
        return Login() ;
      },
    ),
    GoRoute(
      path: RoutesName.productPath,
      builder: (BuildContext context, GoRouterState state) {
        return ProductPage();
      },
    ),
    GoRoute(
      path: RoutesName.cartPath,
      builder: (BuildContext context, GoRouterState state) {
        return CartPage();
      },
    ),
  ],
);
