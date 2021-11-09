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
}

extension SurveyExtension on SurveyResponse {
  Survey toSurvey() => Survey(
        title: this.title ?? "",
        description: this.description ?? "",
        coverImageUrl: this.coverImageUrl ?? "",
      );
}
