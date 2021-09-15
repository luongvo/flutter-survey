import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  bool _requireAuthenticate;

  AppInterceptor(this._requireAuthenticate);

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (_requireAuthenticate) {
      // TODO options.headers.putIfAbsent('Authorization', () => "Add Token here");
    }
    return super.onRequest(options, handler);
  }
}
