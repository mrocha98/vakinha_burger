import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/exceptions/unauthorized_exception.dart';
import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../dto/auth_model.dart';
import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dio);

  final CustomDio _dio;

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final result = await _dio.unauth().post(
        '/auth',
        data: {
          'email': email,
          'password': password,
        },
      );
      return AuthModel.fromMap(result.data);
    } on DioError catch (e, st) {
      if (e.response?.statusCode == HttpStatus.forbidden) {
        log('Permissão negada', error: e, stackTrace: st);
        throw UnauthorizedException();
      }
      const message = 'Erro ao realizar login';
      log(message, error: e, stackTrace: st);
      throw RepositoryException(message: message);
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await _dio.unauth().post(
        '/users',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
    } on DioError catch (e, st) {
      const message = 'Erro ao registrar usuário';
      log(message, error: e, stackTrace: st);
      throw RepositoryException(message: message);
    }
  }
}
