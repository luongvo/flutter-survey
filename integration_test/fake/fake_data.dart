import 'package:dio/dio.dart';

const String LOGIN_KEY = 'login';

class FakeResponse {
  final int statusCode;
  final Map<String, dynamic> json;

  FakeResponse(this.statusCode, this.json);
}

class FakeData {
  FakeData._();

  static Map<String, FakeResponse> fakeResponses = {};

  static void addFakeResponse(String key, FakeResponse newValue) {
    fakeResponses.update(key, (value) => newValue, ifAbsent: () => newValue);
  }
}

DioError fakeDioError(int statusCode) {
  return DioError(
      response: Response(
          statusCode: statusCode, requestOptions: RequestOptions(path: '')),
      type: DioErrorType.response,
      requestOptions: RequestOptions(path: ''));
}
