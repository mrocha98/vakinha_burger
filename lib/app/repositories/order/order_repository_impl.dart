import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../dto/order_dto.dart';
import '../../models/payment_type_model.dart';
import './order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl(this._dio);

  final CustomDio _dio;

  @override
  Future<List<PaymentTypeModel>> getAllPaymentsTypes() async {
    try {
      final result = await _dio.auth().get('/payment-types');
      return result.data
          .map<PaymentTypeModel>((p) => PaymentTypeModel.fromMap(p))
          .toList();
    } on DioError catch (e, st) {
      const message = 'Erro ao buscar formas de pagamento';
      log(message, error: e, stackTrace: st);
      throw RepositoryException(message: message);
    }
  }

  @override
  Future<void> saveOrder(OrderDto order) async {
    try {
      await _dio.auth().post(
        '/orders',
        data: {
          'products': order.products
              .map((e) => {
                    'id': e.product.id,
                    'amount': e.amount,
                    'total_price': e.totalPrice,
                  })
              .toList(growable: false),
          'user_id': '#userAuthRef',
          'address': order.address,
          'CPF': order.document,
          'payment_method_id': order.paymentMethodId,
        },
      );
    } on DioError catch (e, st) {
      const message = 'Erro ao registrar pedido';
      log(message, error: e, stackTrace: st);
      throw RepositoryException(message: message);
    }
  }
}
