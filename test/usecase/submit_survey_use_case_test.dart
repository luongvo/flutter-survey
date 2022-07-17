import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/submit_survey_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/mock_data.mocks.dart';

void main() {
  group('SubmitSurveyUseCaseTest', () {
    late MockSurveyRepository mockRepository;
    late SubmitSurveyUseCase useCase;

    final input = SubmitSurveyInput(
      surveyId: "id",
      questions: [],
    );

    setUp(() async {
      mockRepository = MockSurveyRepository();
      useCase = SubmitSurveyUseCase(mockRepository);
    });

    test('When calling API with valid data, it returns Success result',
        () async {
      when(mockRepository.submitSurvey(any, any)).thenAnswer((_) async => null);
      final result = await useCase.call(input);

      expect(result, isA<Success>());
    });

    test('When calling API with invalid data, it returns Failed result',
        () async {
      when(mockRepository.submitSurvey(any, any))
          .thenAnswer((_) => Future.error(
                NetworkExceptions.unauthorisedRequest(),
              ));
      final result = await useCase.call(input);

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException,
          NetworkExceptions.unauthorisedRequest());
    });
  });
}
