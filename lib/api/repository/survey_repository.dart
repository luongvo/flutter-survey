import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/request/submit_survey_request.dart';
import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_survey/local/database/survey_box_helper.dart';
import 'package:flutter_survey/models/survey.dart';
import 'package:flutter_survey/models/survey_detail.dart';
import 'package:injectable/injectable.dart';

abstract class SurveyRepository {
  Future<List<Survey>> getSurveys(int pageNumber, int pageSize);

  Future<SurveyDetail> getSurveyDetail(String surveyId);

  Future<void> submitSurvey(
    String surveyId,
    List<SubmitQuestion> questions,
  );
}

@Singleton(as: SurveyRepository)
class SurveyRepositoryImpl extends SurveyRepository {
  SurveyService _surveyService;
  SurveyBoxHelper _surveyBox;

  SurveyRepositoryImpl(
    this._surveyService,
    this._surveyBox,
  );

  @override
  Future<List<Survey>> getSurveys(int pageNumber, int pageSize) async {
    try {
      final response = await _surveyService.getSurveyList(
        pageNumber,
        pageSize,
      );
      final surveys =
          response.surveys.map((e) => Survey.fromSurveyResponse(e)).toList();

      _saveCacheSurveys(pageNumber, surveys);

      return surveys;
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

  @override
  Future<void> submitSurvey(
    String surveyId,
    List<SubmitQuestion> questions,
  ) async {
    try {
      return await _surveyService.submitSurvey(SubmitSurveyRequest(
        surveyId: surveyId,
        questions: questions,
      ));
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

  void _saveCacheSurveys(int pageNumber, List<Survey> surveys) {
    if (pageNumber == 1) {
      _surveyBox.clear();
    }
    _surveyBox.saveSurveys(surveys);
  }
}
