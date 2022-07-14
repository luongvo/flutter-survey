import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/get_survey_detail_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/mock_data.mocks.dart';

void main() {
  group('GetSurveyDetailUseCaseTest', () {
    late MockSurveyRepository mockRepository;
    late GetSurveyDetailUseCase getSurveyDetailUseCase;

    setUp(() async {
      mockRepository = MockSurveyRepository();
      getSurveyDetailUseCase = GetSurveyDetailUseCase(mockRepository);
    });

    test('When calling API with valid data, it returns Success result',
        () async {
      final survey = MockSurveyDetail();

      when(mockRepository.getSurveyDetail(any)).thenAnswer((_) async => survey);
      final result = await getSurveyDetailUseCase.call(GetSurveyDetailInput(
        surveyId: "1",
      ));

      expect(result, isA<Success>());
    });

    test('When calling API with invalid data, it returns Failed result',
        () async {
      when(mockRepository.getSurveyDetail(any)).thenAnswer((_) => Future.error(
            NetworkExceptions.unauthorisedRequest(),
          ));
      final result = await getSurveyDetailUseCase.call(GetSurveyDetailInput(
        surveyId: "1",
      ));

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException,
          NetworkExceptions.unauthorisedRequest());
    });
  });
}
