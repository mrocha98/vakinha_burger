import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/rest_client/custom_dio.dart';
import '../../repositories/products/products_repository.dart';
import '../../repositories/products/products_repository_impl.dart';
import 'home_controller.dart';
import 'home_page.dart';

class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<ProductsRepository>(
            create: (context) => ProductsRepositoryImpl(
              context.read<CustomDio>(),
            ),
          ),
          Provider<HomeController>(
            create: (context) => HomeController(
              context.read<ProductsRepository>(),
            ),
          ),
        ],
        child: const HomePage(),
      );
}
