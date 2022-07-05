import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/repository/survey_repository.dart';
import 'package:flutter_survey/api/response/surveys_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mock/mock_data.mocks.dart';
import '../../utils/file_util.dart';

void main() {
  group("SurveyRepositoryTest", () {
    late MockSurveyService mockSurveyService;
    late SurveyRepository surveyRepository;
    late Map<String, dynamic> surveysJson;

    setUp(() async {
      mockSurveyService = MockSurveyService();
      surveyRepository = SurveyRepositoryImpl(mockSurveyService);
      surveysJson = await FileUtil.loadFile('test_resources/surveys.json');
    });

    test(
        'When calling getSurveys successfully, it returns corresponding response',
        () async {
      final response = SurveysResponse.fromJson(surveysJson);

      when(mockSurveyService.getSurveyList(any, any))
          .thenAnswer((_) async => response);
      final result = await surveyRepository.getSurveys(1, 2);

      expect(result.length, 2);
      expect(result[0].title, "Scarlett Bangkok");
      expect(result[1].title, "ibis Bangkok Riverside");
    });

    test('When calling getSurveys failed, it returns NetworkExceptions error',
        () async {
      when(mockSurveyService.getSurveyList(any, any)).thenThrow(MockDioError());
      final result = () => surveyRepository.getSurveys(1, 2);

      expect(result, throwsA(isA<NetworkExceptions>()));
    });
  });
}
