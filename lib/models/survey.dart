import 'package:equatable/equatable.dart';
import 'package:flutter_survey/api/response/survey_response.dart';

class Survey extends Equatable {
  final String id;
  final String title;
  final String description;
  final String coverImageUrl;

  Survey({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImageUrl,
  });

  @override
  List<Object?> get props => [id, title, description, coverImageUrl];

  factory Survey.fromSurveyResponse(SurveyResponse response) {
    return Survey(
      id: response.id,
      title: response.title ?? "",
      description: response.description ?? "",
      coverImageUrl: response.coverImageUrl ?? "",
    );
  }
}
