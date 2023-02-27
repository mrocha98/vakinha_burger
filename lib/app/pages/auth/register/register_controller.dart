import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/auth/auth_repository.dart';
import 'register_state.dart';

class RegisterController extends Cubit<RegisterState> {
  RegisterController(this._authRepository) : super(const RegisterState.initial());

  final AuthRepository _authRepository;

  Future<void> register(String name, String email, String password) async {
    emit(state.copyWith(status: RegisterStatus.register));
    try {
      await _authRepository.register(name, email, password);
      emit(state.copyWith(status: RegisterStatus.success));
    } catch (e, st) {
      log('Erro ao registrar usuário', error: e, stackTrace: st);
      emit(state.copyWith(status: RegisterStatus.error));
    }
  }
}
