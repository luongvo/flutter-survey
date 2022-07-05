import 'package:flutter_survey/api/response/base/base_response_converter.dart';
import 'package:flutter_survey/api/response/question_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_response.g.dart';

@JsonSerializable()
class SurveyResponse {
  final String id;
  String? title;
  String? description;
  @JsonKey(name: "is_active")
  bool? isActive;
  @JsonKey(name: "cover_image_url")
  String? coverImageUrl;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "survey_type")
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
