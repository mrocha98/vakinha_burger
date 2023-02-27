import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/exceptions/unauthorized_exception.dart';
import '../../../repositories/auth/auth_repository.dart';
import 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  LoginController(this._authRepository) : super(const LoginState.initial());

  final AuthRepository _authRepository;

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: LoginStatus.login));
    try {
      final authModel = await _authRepository.login(email, password);

      final cache = GetStorage();
      await Future.wait([
        cache.write('accessToken', authModel.accessToken),
        cache.write('refreshToken', authModel.refreshToken)
      ]);

      emit(state.copyWith(
        status: LoginStatus.success,
        errorMessage: null,
      ));
    } on UnauthorizedException {
      emit(state.copyWith(
        status: LoginStatus.loginError,
        errorMessage: 'Email ou senha inválidos',
      ));
    } catch (e, st) {
      const message = 'Erro ao realizar login';
      log(message, error: e, stackTrace: st);
      emit(state.copyWith(
        status: LoginStatus.error,
        errorMessage: message,
      ));
    }
  }
}
