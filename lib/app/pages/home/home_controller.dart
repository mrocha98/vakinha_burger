import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../repositories/products/products_repository.dart';
import 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  HomeController(this._productsRepository) : super(const HomeState.initial());

  final ProductsRepository _productsRepository;

  Future<void> loadProducts() async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      final products = await _productsRepository.findAllProducts();
      emit(state.copyWith(
        status: HomeStateStatus.loaded,
        products: products,
      ));
    } on RepositoryException catch (e, s) {
      log('HOME_CONTROLLER: erro ao buscar produtos', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: HomeStateStatus.error,
          errorMessage: 'Erro ao buscar produtos',
        ),
      );
    }
  }
}
