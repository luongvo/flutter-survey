// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_http_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseHttpResponse<T> _$BaseHttpResponseFromJson<T extends BaseResponse>(
        Map<String, dynamic> json) =>
    BaseHttpResponse<T>(
      data: ApiResponse<T>.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BaseHttpResponseToJson<T extends BaseResponse>(
        BaseHttpResponse<T> instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
