import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../dto/order_product_dto.dart';
import '../../models/payment_type_model.dart';

part 'order_state.g.dart';

@match
enum OrderStatus {
  initial,
  loading,
  loaded,
  error,
  update,
  confirmRemoveProduct,
  emptyBag,
  success,
}

class OrderState extends Equatable {
  const OrderState({
    required this.status,
    required this.products,
    required this.paymentTypes,
    this.errorMessage,
  });

  const OrderState.initial()
      : status = OrderStatus.initial,
        products = const [],
        paymentTypes = const [],
        errorMessage = null;

  final OrderStatus status;

  final List<OrderProductDto> products;

  final List<PaymentTypeModel> paymentTypes;

  final String? errorMessage;

  @override
  List<Object?> get props => [status, products, paymentTypes, errorMessage];

  double get total => products.fold(
        0.0,
        (previousValue, element) => previousValue + element.totalPrice,
      );

  OrderState copyWith({
    OrderStatus? status,
    List<OrderProductDto>? products,
    List<PaymentTypeModel>? paymentTypes,
    String? errorMessage,
  }) {
    return OrderState(
      status: status ?? this.status,
      products: products ?? this.products,
      paymentTypes: paymentTypes ?? this.paymentTypes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class OrderConfirmDeleteProductState extends OrderState {
  const OrderConfirmDeleteProductState({
    required this.orderProduct,
    required this.index,
    required super.status,
    required super.products,
    required super.paymentTypes,
    super.errorMessage,
  });

  final OrderProductDto orderProduct;

  final int index;
}
