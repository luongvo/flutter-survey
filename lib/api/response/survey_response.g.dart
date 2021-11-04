// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyResponse _$SurveyResponseFromJson(Map<String, dynamic> json) {
  return SurveyResponse(
    title: json['title'] as String?,
    description: json['description'] as String?,
    thankEmailAbove: json['thank_email_above_threshold'] as String?,
    thankEmailBelow: json['thank_email_below_threshold'] as String?,
    isActive: json['is_active'] as bool?,
    coverImageUrl: json['cover_image_url'] as String?,
    createdAt: json['created_at'] as String?,
    activeAt: json['active_at'] as String?,
    inactiveAt: json['inactive_at'] as String?,
    surveyType: json['survey_type'] as String?,
  );
}

Map<String, dynamic> _$SurveyResponseToJson(SurveyResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'thank_email_above_threshold': instance.thankEmailAbove,
      'thank_email_below_threshold': instance.thankEmailBelow,
      'is_active': instance.isActive,
      'cover_image_url': instance.coverImageUrl,
      'created_at': instance.createdAt,
      'active_at': instance.activeAt,
      'inactive_at': instance.inactiveAt,
      'survey_type': instance.surveyType,
    };
