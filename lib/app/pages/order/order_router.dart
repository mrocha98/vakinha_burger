import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/rest_client/custom_dio.dart';
import '../../repositories/order/order_repository.dart';
import '../../repositories/order/order_repository_impl.dart';
import 'order_controller.dart';
import 'order_page.dart';

class OrderRouter {
  OrderRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<OrderRepository>(
            create: (context) => OrderRepositoryImpl(
              context.read<CustomDio>(),
            ),
          ),
          Provider<OrderController>(
            create: (context) => OrderController(
              context.read<OrderRepository>(),
            ),
          ),
        ],
        child: const OrderPage(),
      );
}
