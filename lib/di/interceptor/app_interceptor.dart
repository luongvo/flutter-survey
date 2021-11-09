import 'package:dio/dio.dart';
import 'package:flutter_survey/local/shared_preference_helper.dart';

const String HEADER_AUTHORIZATION = 'Authorization';

class AppInterceptor extends Interceptor {
  bool _requireAuthenticate;
  SharedPreferencesHelper _sharedPreferencesHelper;

  AppInterceptor(
    this._requireAuthenticate,
    this._sharedPreferencesHelper,
  );

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (_requireAuthenticate) {
      String accessToken = await _sharedPreferencesHelper.getAccessToken();
      String tokenType = await _sharedPreferencesHelper.getTokenType();
      options.headers
          .putIfAbsent(HEADER_AUTHORIZATION, () => "$tokenType $accessToken");
    }
    return super.onRequest(options, handler);
  }
}
