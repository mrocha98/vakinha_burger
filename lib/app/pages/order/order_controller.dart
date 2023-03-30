import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../dto/order_dto.dart';
import '../../dto/order_product_dto.dart';
import '../../repositories/order/order_repository.dart';
import 'order_state.dart';

class OrderController extends Cubit<OrderState> {
  OrderController(this._orderRepository) : super(const OrderState.initial());

  final OrderRepository _orderRepository;

  Future<void> load(List<OrderProductDto> products) async {
    emit(state.copyWith(status: OrderStatus.loading));

    try {
      final paymentTypes = await _orderRepository.getAllPaymentsTypes();
      emit(state.copyWith(
        status: OrderStatus.loaded,
        products: products,
        paymentTypes: paymentTypes,
      ));
    } catch (e, st) {
      const message = 'Erro ao carregar meios de pagamento';
      log(message, error: e, stackTrace: st);
      emit(state.copyWith(
        status: OrderStatus.error,
        errorMessage: message,
      ));
    }
  }

  void incrementProduct(int index) {
    final products = [...state.products];
    final order = products[index];
    products[index] = order.copyWith(amount: order.amount + 1);
    emit(state.copyWith(
      products: products,
      status: OrderStatus.update,
    ));
  }

  void decrementProduct(int index) {
    final products = [...state.products];
    final order = products[index];
    final amount = order.amount;

    if (amount == 1) {
      if (state.status != OrderStatus.confirmRemoveProduct) {
        emit(OrderConfirmDeleteProductState(
          orderProduct: order,
          index: index,
          status: OrderStatus.confirmRemoveProduct,
          products: state.products,
          paymentTypes: state.paymentTypes,
          errorMessage: state.errorMessage,
        ));
        return;
      }
      products.removeAt(index);
    } else {
      products[index] = order.copyWith(amount: order.amount - 1);
    }

    if (products.isEmpty) {
      emit(state.copyWith(status: OrderStatus.emptyBag));
      return;
    }
    emit(state.copyWith(
      products: products,
      status: OrderStatus.update,
    ));
  }

  void cancelDeleteProccess() {
    emit(state.copyWith(status: OrderStatus.loaded));
  }

  void emptyBag() {
    emit(state.copyWith(status: OrderStatus.emptyBag));
  }

  Future<void> saveOrder({
    required String address,
    required String document,
    required int paymentMethodId,
  }) async {
    emit(state.copyWith(status: OrderStatus.loading));
    final order = OrderDto(
      products: state.products,
      address: address,
      document: document,
      paymentMethodId: paymentMethodId,
    );
    try {
      await _orderRepository.saveOrder(order);
      emit(state.copyWith(status: OrderStatus.success));
    } on RepositoryException catch (e) {
      emit(state.copyWith(
        status: OrderStatus.error,
        errorMessage: e.message,
      ));
    }
  }
}
