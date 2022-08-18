import 'package:flutter_survey/models/survey.dart';
import 'package:flutter_survey/usecase/get_cache_surveys_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/mock_data.mocks.dart';

void main() {
  group('GetCacheSurveysUseCaseTest', () {
    late MockSurveyBoxHelper mockSurveyBoxHelper;
    late GetCacheSurveysUseCase useCase;

    setUp(() async {
      mockSurveyBoxHelper = MockSurveyBoxHelper();

      useCase = GetCacheSurveysUseCase(mockSurveyBoxHelper);
    });

    test('When fetching cache surveys, it returns cache surveys correctly',
        () async {
      final surveys = <Survey>[MockSurvey()];
      when(mockSurveyBoxHelper.surveys).thenAnswer((_) => surveys);
      final result = await useCase.call();

      expect(result, surveys);
    });
  });
}
