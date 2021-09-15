import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_survey/di/interceptor/app_interceptor.dart';
import 'package:injectable/injectable.dart';

const String HEADER_CONTENT_TYPE = 'Content-Type';
const String DEFAULT_CONTENT_TYPE = 'application/json; charset=utf-8';

@Singleton()
class DioProvider {
  Dio? _nonAuthenticatedDio;
  Dio? _authenticatedDio;

  Dio getNonAuthenticatedDio() {
    if (_nonAuthenticatedDio == null) {
      _nonAuthenticatedDio = _createDio();
    }
    return _nonAuthenticatedDio!;
  }

  Dio getAuthenticatedDio() {
    if (_authenticatedDio == null) {
      _authenticatedDio = _createDio(requireAuthenticate: true);
    }
    return _authenticatedDio!;
  }

  Dio _createDio({bool requireAuthenticate = false}) {
    final dio = Dio();
    final appInterceptor = AppInterceptor(requireAuthenticate);
    final interceptors = <Interceptor>[];
    interceptors.add(appInterceptor);
    if (!kReleaseMode) {
      interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ));
    }

    return dio
      ..options.connectTimeout = 3000
      ..options.receiveTimeout = 5000
      ..options.headers = {HEADER_CONTENT_TYPE: DEFAULT_CONTENT_TYPE}
      ..interceptors.addAll(interceptors);
  }
}
