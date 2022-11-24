import 'package:flutter_survey/api/response/surveys_response.dart';
import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_data.dart';

const String SURVEYS_KEY = 'surveys';

class FakeSurveyService extends Fake implements BaseSurveyService {
  @override
  Future<SurveysResponse> getSurveyList(int pageNumber, int pageSize) async {
    final response = FakeData.fakeResponses[SURVEYS_KEY]!;

    if (response.statusCode != 200) {
      throw fakeDioError(response.statusCode);
    }
    return SurveysResponse.fromJson(response.json);
  }
}
