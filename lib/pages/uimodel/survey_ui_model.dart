import 'package:equatable/equatable.dart';
import 'package:flutter_survey/models/survey.dart';

class SurveyUiModel extends Equatable {
  final String title;
  final String description;
  final String coverImageUrl;

  SurveyUiModel({
    required this.title,
    required this.description,
    required this.coverImageUrl,
  });

  @override
  List<Object?> get props => [title, description, coverImageUrl];

  factory SurveyUiModel.fromSurvey(Survey survey) {
    return SurveyUiModel(
      title: survey.title,
      description: survey.description,
      coverImageUrl: survey.coverImageUrl,
    );
  }
}
