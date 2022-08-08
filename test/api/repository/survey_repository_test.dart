import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/repository/survey_repository.dart';
import 'package:flutter_survey/api/response/survey_detail_response.dart';
import 'package:flutter_survey/api/response/surveys_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mock/mock_data.mocks.dart';
import '../../utils/file_util.dart';

void main() {
  group("SurveyRepositoryTest", () {
    late MockSurveyService mockSurveyService;
    late MockSurveyBoxHelper mockSurveyBoxHelper;
    late SurveyRepository surveyRepository;

    setUp(() async {
      mockSurveyService = MockSurveyService();
      mockSurveyBoxHelper = MockSurveyBoxHelper();
      surveyRepository = SurveyRepositoryImpl(
        mockSurveyService,
        mockSurveyBoxHelper,
      );
    });

    test(
        'When calling getSurveys successfully, it returns corresponding response',
        () async {
      final surveysJson =
          await FileUtil.loadFile('test_resources/surveys.json');
      final response = SurveysResponse.fromJson(surveysJson);

      when(mockSurveyService.getSurveyList(any, any))
          .thenAnswer((_) async => response);
      final result = await surveyRepository.getSurveys(1, 2);

      expect(result.length, 2);
      expect(result[0].title, "Scarlett Bangkok");
      expect(result[1].title, "ibis Bangkok Riverside");

      verify(mockSurveyBoxHelper.clear()).called(1);
      verify(mockSurveyBoxHelper.saveSurveys(result)).called(1);
    });

    test('When calling getSurveys failed, it returns NetworkExceptions error',
        () async {
      when(mockSurveyService.getSurveyList(any, any)).thenThrow(MockDioError());
      final result = () => surveyRepository.getSurveys(1, 2);

      expect(result, throwsA(isA<NetworkExceptions>()));
    });

    test(
        'When calling getSurveyDetail successfully, it returns corresponding response',
        () async {
      final surveyDetailJson =
          await FileUtil.loadFile('test_resources/survey_detail.json');
      final response = SurveyDetailResponse.fromJson(surveyDetailJson);

      when(mockSurveyService.getSurveyDetail(any))
          .thenAnswer((_) async => response);
      final result = await surveyRepository.getSurveyDetail("1");

      expect(result.questions.length, 12);
      expect(result.questions[0].text,
          "\nThank you for visiting Scarlett!\n Please take a moment to share your feedback.");
      expect(
          result.questions[1].text, "Food â€“ Variety, Taste and Presentation");
    });

    test(
        'When calling getSurveyDetail failed, it returns NetworkExceptions error',
        () async {
      when(mockSurveyService.getSurveyDetail(any)).thenThrow(MockDioError());
      final result = () => surveyRepository.getSurveyDetail("1");

      expect(result, throwsA(isA<NetworkExceptions>()));
    });

    test(
        'When calling submitSurvey successfully, it returns corresponding response',
        () async {
      when(mockSurveyService.submitSurvey(any)).thenAnswer((_) async => null);
      await surveyRepository.submitSurvey("1", []);
    });

    test('When calling submitSurvey failed, it returns NetworkExceptions error',
        () async {
      when(mockSurveyService.submitSurvey(any)).thenThrow(MockDioError());
      final result = () => surveyRepository.submitSurvey("1", []);

      expect(result, throwsA(isA<NetworkExceptions>()));
    });
  });
}
