import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_survey/models/survey.dart';
import 'package:injectable/injectable.dart';

abstract class SurveyRepository {
  Future<List<Survey>> getSurveys({
    required int pageNumber,
    required int pageSize,
  });
}

@Singleton(as: SurveyRepository)
class SurveyRepositoryImpl extends SurveyRepository {
  SurveyService _surveyService;

  SurveyRepositoryImpl(this._surveyService);

  @override
  Future<List<Survey>> getSurveys({
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      final responses = await _surveyService
          .getSurveyList(pageNumber, pageSize)
          .then((response) => response.data
              .map((apiResponse) => apiResponse.attributes)
              .toList());
      return responses.map((response) => response.toSurvey()).toList();
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
