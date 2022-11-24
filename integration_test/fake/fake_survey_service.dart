import 'package:flutter_survey/api/request/submit_survey_request.dart';
import 'package:flutter_survey/api/response/survey_detail_response.dart';
import 'package:flutter_survey/api/response/surveys_response.dart';
import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_data.dart';

const String SURVEYS_KEY = 'surveys';
const String SURVEY_KEY = 'survey';
const String SUBMIT_SURVEY_KEY = 'submit_survey';

class FakeSurveyService extends Fake implements BaseSurveyService {
  @override
  Future<SurveysResponse> getSurveyList(int pageNumber, int pageSize) async {
    final response = FakeData.fakeResponses[SURVEYS_KEY]!;

    if (response.statusCode != 200) {
      throw fakeDioError(response.statusCode);
    }
    return SurveysResponse.fromJson(response.json);
  }

  @override
  Future<SurveyDetailResponse> getSurveyDetail(String surveyId) async {
    final response = FakeData.fakeResponses[SURVEY_KEY]!;

    if (response.statusCode != 200) {
      throw fakeDioError(response.statusCode);
    }
    return SurveyDetailResponse.fromJson(response.json);
  }

  @override
  Future<void> submitSurvey(SubmitSurveyRequest body) async {
    final response = FakeData.fakeResponses[SUBMIT_SURVEY_KEY]!;

    if (response.statusCode != 200) {
      throw fakeDioError(response.statusCode);
    }
    return Future.delayed(Duration.zero);
  }
}
