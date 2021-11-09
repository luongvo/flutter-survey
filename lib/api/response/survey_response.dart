import 'package:flutter_survey/api/response/base/base_http_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_response.g.dart';

@JsonSerializable()
class SurveyResponse extends BaseResponse {
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

  SurveyResponse(
      {this.title,
      this.description,
      this.isActive,
      this.coverImageUrl,
      this.createdAt,
      this.surveyType});

  factory SurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyResponseToJson(this);
}
