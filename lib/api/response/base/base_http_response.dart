import 'package:flutter_survey/api/response/base/api_response.dart';
import 'package:json_annotation/json_annotation.dart';

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

class BaseHttpResponseList<T extends BaseResponse> {
  List<ApiResponse<T>> data;

  BaseHttpResponseList({required this.data});

  factory BaseHttpResponseList.fromJson(Map<String, dynamic> json) {
    return BaseHttpResponseList<T>(
      data: (json['data'] as List<dynamic>)
          .map((e) => ApiResponse<T>.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': this.data,
      };
}
