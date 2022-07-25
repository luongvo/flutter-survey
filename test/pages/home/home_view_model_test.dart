import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/models/survey.dart';
import 'package:flutter_survey/pages/home/home_page.dart';
import 'package:flutter_survey/pages/home/home_state.dart';
import 'package:flutter_survey/pages/home/home_view_model.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test/mock/mock_data.mocks.dart';

void main() {
  group('HomeViewModelTest', () {
    late MockGetSurveysUseCase mockGetSurveysUseCase;
    late ProviderContainer container;

    setUp(() {
      mockGetSurveysUseCase = MockGetSurveysUseCase();
      container = ProviderContainer(
        overrides: [
          homeViewModelProvider
              .overrideWithValue(HomeViewModel(mockGetSurveysUseCase)),
        ],
      );
      addTearDown(container.dispose);
    });

    test('When initializing, it initializes with Init state', () {
      expect(container.read(homeViewModelProvider), HomeState.init());
    });

    test(
        'When calling load survey list with positive result, it returns Success state',
        () {
      final surveys = <Survey>[];

      when(mockGetSurveysUseCase.call(any))
          .thenAnswer((_) async => Success(surveys));
      final stateStream = container.read(homeViewModelProvider.notifier).stream;
      final surveysStream =
          container.read(homeViewModelProvider.notifier).surveysStream;
      expect(stateStream,
          emitsInOrder([HomeState.loading(), HomeState.success()]));
      expect(surveysStream, emitsInOrder([surveys]));

      container.read(homeViewModelProvider.notifier).loadSurveys();
    });

    test(
        'When calling load survey list with negative result, it returns Failed state accordingly',
        () {
      final mockException = MockUseCaseException();
      when(mockException.actualException)
          .thenReturn(NetworkExceptions.internalServerError());
      when(mockGetSurveysUseCase.call(any))
          .thenAnswer((_) async => Failed(mockException));
      final stateStream = container.read(homeViewModelProvider.notifier).stream;
      expect(
          stateStream,
          emitsInOrder([
            HomeState.loading(),
            HomeState.error(
              NetworkExceptions.getErrorMessage(
                  NetworkExceptions.internalServerError()),
            )
          ]));
      container.read(homeViewModelProvider.notifier).loadSurveys();
    });
  });
}
