import 'package:flutter_survey/api/response/base/base_http_response.dart';
import 'package:flutter_survey/api/response/oauth_token_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse<T extends BaseResponse> {
  dynamic id;
  String type;
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  T attributes;

  ApiResponse({required this.id, required this.type, required this.attributes});

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

  static T _dataFromJson<T>(Map<String, dynamic> json) {
    if (T == OAuthTokenResponse) {
      return OAuthTokenResponse.fromJson(json) as T;
    } else {
      throw Exception("_dataFromJson Not supported response type");
    }
  }

  static Map<String, dynamic> _dataToJson<T>(T value) {
    if (T is OAuthTokenResponse) {
      return (T as OAuthTokenResponse).toJson();
    } else {
      throw Exception("_dataToJson Not supported response type");
    }
  }
}
