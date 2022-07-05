import 'package:flutter_survey/api/response/base/base_response_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_response.g.dart';

@JsonSerializable()
class QuestionResponse {
  final String id;
  final String? text;
  @JsonKey(name: 'display_order')
  final int? displayOrder;
  @JsonKey(name: 'display_type')
  final String? displayType;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'cover_image_url')
  final String? coverImageUrl;
  @JsonKey(name: 'cover_image_opacity')
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
