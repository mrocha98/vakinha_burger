import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../models/product_model.dart';

part 'home_state.g.dart';

@match
enum HomeStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class HomeState extends Equatable {
  const HomeState({
    required this.status,
    required this.products,
    this.errorMessage,
  });

  const HomeState.initial()
      : status = HomeStateStatus.initial,
        products = const [],
        errorMessage = null;

  final HomeStateStatus status;

  final List<ProductModel> products;

  final String? errorMessage;

  @override
  List<Object?> get props => [status, products, errorMessage];

  HomeState copyWith({
    HomeStateStatus? status,
    List<ProductModel>? products,
    String? errorMessage,
  }) =>
      HomeState(
        status: status ?? this.status,
        products: products ?? this.products,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
