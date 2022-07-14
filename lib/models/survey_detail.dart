import 'package:equatable/equatable.dart';
import 'package:flutter_survey/api/response/survey_detail_response.dart';
import 'package:flutter_survey/models/question.dart';

class SurveyDetail extends Equatable {
  final List<Question> questions;

  SurveyDetail({
    required this.questions,
  });

  @override
  List<Object?> get props => [questions];

  factory SurveyDetail.fromSurveyDetailResponse(SurveyDetailResponse response) {
    return SurveyDetail(
      questions: response.questions
          .map((e) => Question.fromQuestionResponse(e))
          .toList(),
    );
  }
}
