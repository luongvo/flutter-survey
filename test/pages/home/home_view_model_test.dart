import 'dart:ffi';

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
    late MockGetUserProfileUseCase mockGetUserProfileUseCase;
    late MockGetSurveysUseCase mockGetSurveysUseCase;
    late MockLogoutUseCase mockLogoutUseCase;
    late MockGetCacheSurveysUseCase mockGetCacheSurveysUseCase;
    late ProviderContainer container;
    late List<Survey> surveys;

    setUp(() {
      mockGetUserProfileUseCase = MockGetUserProfileUseCase();
      mockGetSurveysUseCase = MockGetSurveysUseCase();
      mockLogoutUseCase = MockLogoutUseCase();
      mockGetCacheSurveysUseCase = MockGetCacheSurveysUseCase();

      surveys = <Survey>[];
      when(mockGetCacheSurveysUseCase.call()).thenAnswer((_) => surveys);

      container = ProviderContainer(
        overrides: [
          homeViewModelProvider.overrideWithValue(HomeViewModel(
            mockGetUserProfileUseCase,
            mockGetSurveysUseCase,
            mockGetCacheSurveysUseCase,
            mockLogoutUseCase,
          )),
        ],
      );
      addTearDown(container.dispose);
    });

    test('When initializing, it loads cache surveys correctly', () {
      final surveysStream =
          container.read(homeViewModelProvider.notifier).surveysStream;
      expect(surveysStream, emitsInOrder([surveys]));

      expect(container.read(homeViewModelProvider), const HomeState.success());
    });

    test(
        'When calling load user profile with positive result, it returns Success state',
        () {
      final user = MockUser();

      when(mockGetUserProfileUseCase.call())
          .thenAnswer((_) async => Success(user));
      final userStream =
          container.read(homeViewModelProvider.notifier).userStream;
      expect(userStream, emitsInOrder([user]));

      container.read(homeViewModelProvider.notifier).getUserProfile();
    });

    test(
        'When calling load user profile with negative result, it returns Failed state accordingly',
        () {
      final mockException = MockUseCaseException();
      when(mockException.actualException)
          .thenReturn(NetworkExceptions.internalServerError());
      when(mockGetUserProfileUseCase.call())
          .thenAnswer((_) async => Failed(mockException));
      final stateStream = container.read(homeViewModelProvider.notifier).stream;
      expect(
          stateStream,
          emitsInOrder([
            HomeState.error(
              NetworkExceptions.getErrorMessage(
                  NetworkExceptions.internalServerError()),
            )
          ]));
      container.read(homeViewModelProvider.notifier).getUserProfile();
    });

    test(
        'When calling load survey list with positive result, it returns Success state',
        () {
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

    test('When calling logout with positive result, it returns LoggedOut state',
        () {
      when(mockLogoutUseCase.call()).thenAnswer((_) async => Success(Void));
      final stateStream = container.read(homeViewModelProvider.notifier).stream;
      expect(
          stateStream,
          emitsInOrder([
            HomeState.loading(),
            HomeState.loggedOut(),
          ]));

      container.read(homeViewModelProvider.notifier).logout();
    });

    test(
        'When calling logout with negative result, it returns Failed state accordingly',
        () {
      final mockException = MockUseCaseException();
      when(mockException.actualException)
          .thenReturn(NetworkExceptions.internalServerError());
      when(mockLogoutUseCase.call())
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
      container.read(homeViewModelProvider.notifier).logout();
    });
  });
}
