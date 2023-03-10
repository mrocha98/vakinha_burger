import 'package:flutter/material.dart';

import 'core/provider/application_binding.dart';
import 'core/ui/theme/theme_config.dart';
import 'pages/auth/login/login_page.dart';
import 'pages/auth/login/login_router.dart';
import 'pages/auth/register/register_page.dart';
import 'pages/auth/register/register_router.dart';
import 'pages/home/home_page.dart';
import 'pages/home/home_router.dart';
import 'pages/order/order_page.dart';
import 'pages/product_detail/product_detail_page.dart';
import 'pages/product_detail/product_detail_router.dart';
import 'pages/splash/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: 'Vakinha Burger',
        theme: ThemeConfig.theme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        routes: {
          SplashPage.routeName: (_) => const SplashPage(),
          HomePage.routeName: (_) => HomeRouter.page,
          ProductDetailPage.routeName: (_) => ProductDetailRouter.page,
          LoginPage.routeName: (_) => LoginRouter.page,
          RegisterPage.routeName: (_) => RegisterRouter.page,
          OrderPage.routeName: (_) => const OrderPage(),
        },
      ),
    );
  }
}
