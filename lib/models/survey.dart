import 'package:equatable/equatable.dart';
import 'package:flutter_survey/api/response/survey_response.dart';

class Survey extends Equatable {
  final String title;
  final String description;
  final String thankEmailAbove;
  final String thankEmailBelow;
  final String coverImageUrl;

  Survey({
    required this.title,
    required this.description,
    required this.thankEmailAbove,
    required this.thankEmailBelow,
    required this.coverImageUrl,
  });

  @override
  List<Object?> get props =>
      [title, description, thankEmailAbove, thankEmailBelow, coverImageUrl];
}

extension SurveyExtension on SurveyResponse {
  Survey toSurvey() => Survey(
        title: this.title ?? "",
        description: this.description ?? "",
        thankEmailAbove: this.thankEmailAbove ?? "",
        thankEmailBelow: this.thankEmailBelow ?? "",
        coverImageUrl: this.coverImageUrl ?? "",
      );
}
