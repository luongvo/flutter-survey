import 'package:equatable/equatable.dart';
import 'package:flutter_survey/api/response/question_response.dart';

class Question extends Equatable {
  final String id;
  final String text;
  final int displayOrder;
  final String displayType;
  final String imageUrl;
  final String coverImageUrl;
  final double coverImageOpacity;

  Question({
    required this.id,
    required this.text,
    required this.displayOrder,
    required this.displayType,
    required this.imageUrl,
    required this.coverImageOpacity,
    required this.coverImageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        text,
        displayOrder,
        displayType,
        imageUrl,
        coverImageOpacity,
        coverImageUrl
      ];

  factory Question.fromQuestionResponse(QuestionResponse response) {
    return Question(
      id: response.id,
      text: response.text ?? '',
      displayOrder: response.displayOrder ?? 0,
      displayType: response.displayType ?? '',
      imageUrl: response.imageUrl ?? "",
      coverImageOpacity: response.coverImageOpacity ?? 0,
      coverImageUrl: response.coverImageUrl ?? "",
    );
  }
}
