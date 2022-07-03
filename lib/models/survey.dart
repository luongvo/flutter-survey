import 'package:equatable/equatable.dart';
import 'package:flutter_survey/api/response/survey_response.dart';

class Survey extends Equatable {
  final String title;
  final String description;
  final String coverImageUrl;

  Survey({
    required this.title,
    required this.description,
    required this.coverImageUrl,
  });

  @override
  List<Object?> get props => [title, description, coverImageUrl];

  factory Survey.fromSurveyResponse(SurveyResponse surveyResponse) {
    return Survey(
      title: surveyResponse.title ?? "",
      description: surveyResponse.description ?? "",
      coverImageUrl: surveyResponse.coverImageUrl ?? "",
    );
  }
}
