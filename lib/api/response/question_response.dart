import 'package:flutter_survey/api/response/base/base_response_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_response.g.dart';

@JsonSerializable()
class QuestionResponse {
  final String id;
  final String? text;
  final int? displayOrder;
  final String? displayType;
  final String? imageUrl;
  final String? coverImageUrl;
  final double? coverImageOpacity;

  QuestionResponse({
    required this.id,
    required this.text,
    required this.displayOrder,
    required this.displayType,
    required this.imageUrl,
    required this.coverImageUrl,
    required this.coverImageOpacity,
  });

  factory QuestionResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionResponseFromJson(fromJsonApi(json));
}