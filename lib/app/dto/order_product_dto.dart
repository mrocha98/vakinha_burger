import '../models/product_model.dart';

class OrderProductDto {
  OrderProductDto({
    required this.product,
    required this.amount,
  });
  final ProductModel product;
  final int amount;

  double get totalPrice => amount * product.price;
}
