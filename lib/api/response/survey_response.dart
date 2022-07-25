import 'package:flutter_survey/api/response/base/base_response_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_response.g.dart';

@JsonSerializable()
class SurveyResponse {
  final String id;
  String? title;
  String? description;
  bool? isActive;
  String? coverImageUrl;
  String? createdAt;
  String? surveyType;

  SurveyResponse({
    required this.id,
    this.title,
    this.description,
    this.isActive,
    this.coverImageUrl,
    this.createdAt,
    this.surveyType,
  });

  factory SurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFromJson(fromJsonApi(json));
}
