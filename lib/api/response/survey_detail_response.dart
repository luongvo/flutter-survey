import 'package:flutter_survey/api/response/base/base_response_converter.dart';
import 'package:flutter_survey/api/response/question_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_detail_response.g.dart';

/// SurveyResponse from v1/surveys API does not fully contain question list.
/// We need to create a new class to parse the question list.
@JsonSerializable()
class SurveyDetailResponse {
  final String id;
  final List<QuestionResponse> questions;

  SurveyDetailResponse({
    required this.id,
    required this.questions,
  });

  factory SurveyDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyDetailResponseFromJson(fromJsonApi(json));
}
