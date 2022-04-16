// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse<T> _$ApiResponseFromJson<T extends BaseResponse>(
        Map<String, dynamic> json) =>
    ApiResponse<T>(
      id: json['id'],
      type: json['type'] as String,
      attributes:
          ApiResponse._dataFromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiResponseToJson<T extends BaseResponse>(
        ApiResponse<T> instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': ApiResponse._dataToJson(instance.attributes),
    };
