import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/product_model.dart';
import 'products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  ProductsRepositoryImpl(this._dio);

  final CustomDio _dio;

  @override
  Future<List<ProductModel>> findAllProducts() async {
    try {
      final result = await _dio.unauth().get('/products');
      final data = result.data as Iterable;
      return data.map((item) => ProductModel.fromMap(item)).toList();
    } on DioError catch (e, s) {
      const message = 'Erro ao buscar produtos';
      log(message, error: e, stackTrace: s);
      throw RepositoryException(message: message);
    }
  }
}
