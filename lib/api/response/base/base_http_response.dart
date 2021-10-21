import 'package:flutter_survey/api/response/base/api_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_http_response.g.dart';

abstract class BaseResponse {}

@JsonSerializable()
class BaseHttpResponse<T extends BaseResponse> {
  final ApiResponse<T> data;

  BaseHttpResponse({required this.data});

  factory BaseHttpResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseHttpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseHttpResponseToJson(this);
}
