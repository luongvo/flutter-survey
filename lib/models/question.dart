import 'package:equatable/equatable.dart';
import 'package:flutter_survey/api/response/question_response.dart';
import 'package:flutter_survey/models/answer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class Question extends Equatable {
  final String id;
  final String text;
  final int displayOrder;
  final DisplayType displayType;
  final String imageUrl;
  final String coverImageUrl;
  final double coverImageOpacity;
  final List<Answer> answers;

  Question({
    required this.id,
    required this.text,
    required this.displayOrder,
    required this.displayType,
    required this.imageUrl,
    required this.coverImageOpacity,
    required this.coverImageUrl,
    required this.answers,
  });

  @override
  List<Object?> get props =>
      [
        id,
        text,
        displayOrder,
        displayType,
        imageUrl,
        coverImageOpacity,
        coverImageUrl,
        answers,
      ];

  factory Question.fromQuestionResponse(QuestionResponse response) {
    return Question(
      id: response.id,
      text: response.text ?? '',
      displayOrder: response.displayOrder ?? 0,
      displayType: enumFromString(DisplayType.values, response.displayType) ??
          DisplayType.unknown,
      imageUrl: response.imageUrl ?? "",
      coverImageOpacity: response.coverImageOpacity ?? 0,
      coverImageUrl: response.coverImageUrl ?? "",
      answers: response.answers
          .map((answer) => Answer.fromAnswerResponse(answer))
          .toList(),
    );
  }

  static T? enumFromString<T>(Iterable<T> values, String? value) {
    return values
        .firstWhereOrNull((type) => type.toString().split(".").last == value);
  }
}

enum DisplayType {
  star,
  heart,
  smiley,
  choice,
  nps,
  textarea,
  textfield,
  dropdown,
  money,
  slider,
  intro,
  outro,
  unknown,
}
