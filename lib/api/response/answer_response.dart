import 'package:flutter_survey/api/response/base/base_response_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'answer_response.g.dart';

@JsonSerializable()
class AnswerResponse {
  final String id;
  final String? text;
  final int displayOrder;
  final String displayType;

  AnswerResponse({
    required this.id,
    required this.text,
    required this.displayOrder,
    required this.displayType,
  });

  factory AnswerResponse.fromJson(Map<String, dynamic> json) =>
      _$AnswerResponseFromJson(fromJsonApi(json));
}
