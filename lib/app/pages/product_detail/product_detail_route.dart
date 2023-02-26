import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'product_detail_controller.dart';
import 'product_detail_page.dart';

class ProductDetailRoute {
  ProductDetailRoute._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<ProductDetailController>(
            create: (context) => ProductDetailController(),
          )
        ],
        builder: (context, child) {
          final arguments = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return ProductDetailPage(
            product: arguments['product'],
            order: arguments['order'],
          );
        },
      );
}
