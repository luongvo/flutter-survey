import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/local/shared_preference_helper.dart';
import 'package:flutter_survey/models/oauth_token.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/refresh_token_use_case.dart';

const String _headerAuthorization = 'Authorization';

class AppInterceptor extends QueuedInterceptor {
  final bool _requireAuthenticate;
  final SharedPreferencesHelper _sharedPreferencesHelper;
  final Dio _dio;

  AppInterceptor(
    this._requireAuthenticate,
    this._sharedPreferencesHelper,
    this._dio,
  );

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (_requireAuthenticate) {
      final token = await _buildToken();
      options.headers.putIfAbsent(_headerAuthorization, () => token);
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    if ((statusCode == HttpStatus.forbidden ||
            statusCode == HttpStatus.unauthorized) &&
        _requireAuthenticate) {
      try {
        final refreshTokenUseCase = getIt<RefreshTokenUseCase>();
        final result = await refreshTokenUseCase.call();
        if (result is Success<OAuthToken>) {
          // Update new token header
          final newToken = await _buildToken();
          err.requestOptions.headers[_headerAuthorization] = newToken;

          // Create request with new access token
          final options = Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers);
          final newRequest = await _dio.request(
              "${err.requestOptions.baseUrl}${err.requestOptions.path}",
              options: options,
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters);
          handler.resolve(newRequest);
        } else {
          handler.next(err);
        }
      } catch (exception) {
        if (exception is DioError) {
          handler.next(exception);
        } else {
          handler.next(err);
        }
      }
    } else {
      handler.next(err);
    }
  }

  Future<String> _buildToken() async {
    final tokenType = await _sharedPreferencesHelper.getTokenType();
    final accessToken = await _sharedPreferencesHelper.getAccessToken();
    return '$tokenType $accessToken';
  }
}
