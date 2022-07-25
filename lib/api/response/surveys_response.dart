import 'package:flutter_survey/api/response/base/base_response_converter.dart';
import 'package:flutter_survey/api/response/survey_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'surveys_response.g.dart';

@JsonSerializable()
class SurveysResponse {
  @JsonKey(name: 'data')
  final List<SurveyResponse> surveys;

  const SurveysResponse({
    required this.surveys,
  });

  factory SurveysResponse.fromJson(Map<String, dynamic> json) {
    return _$SurveysResponseFromJson(fromRootJsonApi(json));
  }
}
