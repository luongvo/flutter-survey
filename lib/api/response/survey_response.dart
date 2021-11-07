import 'package:flutter_survey/api/response/base/base_http_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_response.g.dart';

@JsonSerializable()
class SurveyResponse extends BaseResponse {
  String? title;
  String? description;
  @JsonKey(name: "thank_email_above_threshold")
  String? thankEmailAbove;
  @JsonKey(name: "thank_email_below_threshold")
  String? thankEmailBelow;
  @JsonKey(name: "is_active")
  bool? isActive;
  @JsonKey(name: "cover_image_url")
  String? coverImageUrl;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "active_at")
  String? activeAt;
  @JsonKey(name: "inactive_at")
  String? inactiveAt;
  @JsonKey(name: "survey_type")
  String? surveyType;

  SurveyResponse(
      {this.title,
      this.description,
      this.thankEmailAbove,
      this.thankEmailBelow,
      this.isActive,
      this.coverImageUrl,
      this.createdAt,
      this.activeAt,
      this.inactiveAt,
      this.surveyType});

  factory SurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyResponseToJson(this);
}