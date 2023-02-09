import 'package:meta/meta.dart';

import '../models/product_model.dart';

@immutable
class OrderProductDto {
  const OrderProductDto({
    required this.product,
    required this.amount,
  });

  final ProductModel product;

  final int amount;

  double get totalPrice => amount * product.price;
}
