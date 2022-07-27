import 'package:flutter_survey/models/answer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'submit_survey_request.g.dart';

@JsonSerializable()
class SubmitSurveyRequest {
  final String surveyId;
  final List<SubmitQuestion> questions;

  SubmitSurveyRequest({required this.surveyId, required this.questions});

  factory SubmitSurveyRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitSurveyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitSurveyRequestToJson(this);
}

@JsonSerializable()
class SubmitQuestion {
  final String id;
  final List<SubmitAnswer> answers;

  SubmitQuestion({required this.id, required this.answers});

  factory SubmitQuestion.fromJson(Map<String, dynamic> json) =>
      _$SubmitQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitQuestionToJson(this);
}

@JsonSerializable()
class SubmitAnswer {
  final String id;
  String answer;

  SubmitAnswer({required this.id, required this.answer});

  factory SubmitAnswer.fromJson(Map<String, dynamic> json) =>
      _$SubmitAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitAnswerToJson(this);

  factory SubmitAnswer.fromAnswer(Answer answer) {
    return SubmitAnswer(
      id: answer.id,
      answer: answer.text,
    );
  }
}
