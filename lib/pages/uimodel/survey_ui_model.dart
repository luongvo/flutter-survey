import 'package:equatable/equatable.dart';
import 'package:flutter_survey/models/question.dart';
import 'package:flutter_survey/models/survey.dart';
import 'package:flutter_survey/models/survey_detail.dart';

class SurveyUiModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String coverImageUrl;

  final List<Question> questions;

  SurveyUiModel({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImageUrl,
    required this.questions,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        coverImageUrl,
        questions,
      ];

  factory SurveyUiModel.fromSurvey(Survey survey) {
    return SurveyUiModel(
      id: survey.id,
      title: survey.title,
      description: survey.description,
      coverImageUrl: survey.coverImageUrl,
      questions: [],
    );
  }

  factory SurveyUiModel.fromSurveyDetail(
    SurveyUiModel survey,
    SurveyDetail surveyDetail,
  ) {
    return SurveyUiModel(
      id: survey.id,
      title: survey.title,
      description: survey.description,
      coverImageUrl: survey.coverImageUrl,
      questions: surveyDetail.questions,
    );
  }
}
