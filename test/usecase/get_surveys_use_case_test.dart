import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/models/survey.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/get_surveys_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/mock_data.mocks.dart';

void main() {
  group('GetSurveysUseCaseTest', () {
    late MockSurveyRepository mockRepository;
    late GetSurveysUseCase getSurveysUseCase;

    setUp(() async {
      mockRepository = MockSurveyRepository();
      getSurveysUseCase = GetSurveysUseCase(mockRepository);
    });

    test('When calling API with valid data, it returns Success result',
        () async {
      final surveys = <Survey>[];

      when(mockRepository.getSurveys(any, any))
          .thenAnswer((_) async => surveys);
      final result = await getSurveysUseCase.call(GetSurveysInput(
        pageNumber: 1,
        pageSize: 2,
      ));

      expect(result, isA<Success>());
    });

    test('When calling API with invalid data, it returns Failed result',
        () async {
      when(mockRepository.getSurveys(any, any)).thenAnswer((_) => Future.error(
            NetworkExceptions.unauthorisedRequest(),
          ));
      final result = await getSurveysUseCase.call(GetSurveysInput(
        pageNumber: 1,
        pageSize: 2,
      ));

      expect(result, isA<Failed>());
      expect((result as Failed).exception.networkExceptions,
          NetworkExceptions.unauthorisedRequest());
    });
  });
}
