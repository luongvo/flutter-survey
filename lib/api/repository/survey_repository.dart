import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_survey/models/survey.dart';
import 'package:injectable/injectable.dart';

abstract class SurveyRepository {
  Future<List<Survey>> getSurveys(int pageNumber, int pageSize);

  Future<Survey> getSurveyDetail(String surveyId);
}

@Singleton(as: SurveyRepository)
class SurveyRepositoryImpl extends SurveyRepository {
  SurveyService _surveyService;

  SurveyRepositoryImpl(this._surveyService);

  @override
  Future<List<Survey>> getSurveys(int pageNumber, int pageSize) async {
    try {
      final response = await _surveyService.getSurveyList(
        pageNumber,
        pageSize,
      );
      return response.surveys
          .map((response) => Survey.fromSurveyResponse(response))
          .toList();
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

  @override
  Future<Survey> getSurveyDetail(String surveyId) async {
    try {
      final response = await _surveyService.getSurveyDetail(surveyId);
      return Survey.fromSurveyResponse(response);
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
