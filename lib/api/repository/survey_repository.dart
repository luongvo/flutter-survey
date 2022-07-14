import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_survey/models/survey.dart';
import 'package:flutter_survey/models/survey_detail.dart';
import 'package:injectable/injectable.dart';

abstract class SurveyRepository {
  Future<List<Survey>> getSurveys(int pageNumber, int pageSize);

  Future<SurveyDetail> getSurveyDetail(String surveyId);
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
      return response.surveys.map((e) => Survey.fromSurveyResponse(e)).toList();
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

  @override
  Future<SurveyDetail> getSurveyDetail(String surveyId) async {
    try {
      final response = await _surveyService.getSurveyDetail(surveyId);
      return SurveyDetail.fromSurveyDetailResponse(response);
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
