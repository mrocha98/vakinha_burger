import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dto/order_product_dto.dart';
import '../../models/product_model.dart';
import 'product_detail_controller.dart';
import 'product_detail_page.dart';

class ProductDetailRouter {
  ProductDetailRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<ProductDetailController>(
            create: (_) => ProductDetailController(),
          ),
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          final ProductModel product = args['product'];
          final OrderProductDto? order = args['order'];
          return ProductDetailPage(
            product: product,
            order: order,
          );
        },
      );
}
