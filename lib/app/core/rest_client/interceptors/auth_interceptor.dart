import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../exceptions/expired_token_exception.dart';
import '../../global/global_context.dart';
import '../custom_dio.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._dio);

  final _cache = GetStorage();

  final CustomDio _dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = _cache.read<String>('accessToken');
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      if (err.requestOptions.path != '/auth/refresh') {
        try {
          await _refreshToken(err);
          await _retryRequest(err, handler);
        } catch (_) {
          GlobalContext.I.loginExpire();
        }
      } else {
        GlobalContext.I.loginExpire();
      }
    } else {
      handler.next(err);
    }
  }

  Future<void> _refreshToken(DioError err) async {
    final refreshToken = _cache.read<String>('refreshToken');
    if (refreshToken == null) return;
    try {
      final resultRefresh = await _dio.put(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );
      await Future.wait([
        _cache.write('accessToken', resultRefresh.data['access_token']),
        _cache.write('refreshToken', resultRefresh.data['refresh_token']),
      ]);
    } on DioError catch (err, st) {
      log('Erro ao realizar refresh token', error: err, stackTrace: st);
      throw ExpiredTokenException();
    }
  }

  Future<void> _retryRequest(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;
    final result = await _dio.request(
      requestOptions.path,
      options: Options(
        headers: requestOptions.headers,
        method: requestOptions.method,
      ),
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );
    handler.resolve(Response(
      requestOptions: requestOptions,
      data: result.data,
      statusCode: result.statusCode,
      statusMessage: result.statusMessage,
    ));
  }
}
