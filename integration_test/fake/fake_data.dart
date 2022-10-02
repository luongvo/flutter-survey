import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

const String LOGIN_KEY = 'login';

class FakeResponse extends Equatable {
  final int statusCode;
  final Map<String, dynamic> json;

  FakeResponse(this.statusCode, this.json);

  @override
  List<Object?> get props => [statusCode, json];
}

class FakeData {
  FakeData._();

  static Map<String, FakeResponse> fakeResponses = {};

  static void updateResponse(String key, FakeResponse newValue) {
    fakeResponses.update(key, (value) => newValue, ifAbsent: () => newValue);
  }
}

DioError dioError(int statusCode) {
  return DioError(
      response: Response(
          statusCode: statusCode, requestOptions: RequestOptions(path: '')),
      type: DioErrorType.response,
      requestOptions: RequestOptions(path: ''));
}
