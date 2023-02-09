import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:meta/meta.dart';

import '../../dto/order_product_dto.dart';
import '../../models/product_model.dart';

part 'home_state.g.dart';

@match
enum HomeStateStatus {
  initial,
  loading,
  loaded,
  error,
}

@immutable
class HomeState extends Equatable {
  const HomeState({
    required this.status,
    required this.products,
    required this.shoppingBag,
    this.errorMessage,
  });

  const HomeState.initial()
      : status = HomeStateStatus.initial,
        products = const [],
        shoppingBag = const [],
        errorMessage = null;

  final HomeStateStatus status;

  final List<ProductModel> products;

  final String? errorMessage;

  final List<OrderProductDto> shoppingBag;

  @override
  List<Object?> get props => [status, products, errorMessage];

  HomeState copyWith({
    HomeStateStatus? status,
    List<ProductModel>? products,
    List<OrderProductDto>? shoppingBag,
    String? errorMessage,
  }) =>
      HomeState(
        status: status ?? this.status,
        products: products ?? this.products,
        shoppingBag: shoppingBag ?? this.shoppingBag,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
