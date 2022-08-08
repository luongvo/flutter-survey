import 'package:equatable/equatable.dart';
import 'package:flutter_survey/api/response/survey_response.dart';
import 'package:hive/hive.dart';

part 'survey.g.dart';

@HiveType(typeId: 0)
class Survey extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
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
