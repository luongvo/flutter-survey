// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyResponse _$SurveyResponseFromJson(Map<String, dynamic> json) =>
    SurveyResponse(
      title: json['title'] as String?,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool?,
      coverImageUrl: json['cover_image_url'] as String?,
      createdAt: json['created_at'] as String?,
      surveyType: json['survey_type'] as String?,
    );

Map<String, dynamic> _$SurveyResponseToJson(SurveyResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'is_active': instance.isActive,
      'cover_image_url': instance.coverImageUrl,
      'created_at': instance.createdAt,
      'survey_type': instance.surveyType,
    };
