import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/pages/login/login_page.dart';
import 'package:flutter_survey/pages/login/login_state.dart';
import 'package:flutter_survey/pages/login/login_view_model.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test/mock/mock_data.mocks.dart';

void main() {
  group('LoginViewModelTest', () {
    late MockLoginUseCase mockLoginUseCase;
    late ProviderContainer container;

    setUp(() {
      mockLoginUseCase = MockLoginUseCase();
      container = ProviderContainer(
        overrides: [
          loginViewModelProvider
              .overrideWithValue(LoginViewModel(mockLoginUseCase)),
        ],
      );
      addTearDown(container.dispose);
    });

    test('When initializing, it initializes with Init state', () {
      expect(container.read(loginViewModelProvider), LoginState.init());
    });

    test('When calling login with positive result, it returns Success state',
        () {
      when(mockLoginUseCase.call(any)).thenAnswer((_) async => Success(null));
      final stateStream =
          container.read(loginViewModelProvider.notifier).stream;
      expect(stateStream,
          emitsInOrder([LoginState.loading(), LoginState.success()]));
      container
          .read(loginViewModelProvider.notifier)
          .login('email', 'password');
    });

    test(
        'When calling login with negative result as unauthorizedRequest error, it returns Failed state accordingly',
        () {
      final mockException = MockUseCaseException();
      when(mockException.networkExceptions)
          .thenReturn(NetworkExceptions.unauthorisedRequest());
      when(mockLoginUseCase.call(any))
          .thenAnswer((_) async => Failed(mockException));
      final stateStream =
          container.read(loginViewModelProvider.notifier).stream;
      expect(
          stateStream,
          emitsInOrder([
            LoginState.loading(),
            LoginState.error(null),
          ]));
      container
          .read(loginViewModelProvider.notifier)
          .login('email', 'password');
    });

    test(
        'When calling login with negative result as other errors, it returns Failed state accordingly',
        () {
      final mockException = MockUseCaseException();
      when(mockException.networkExceptions)
          .thenReturn(NetworkExceptions.internalServerError());
      when(mockLoginUseCase.call(any))
          .thenAnswer((_) async => Failed(mockException));
      final stateStream =
          container.read(loginViewModelProvider.notifier).stream;
      expect(
          stateStream,
          emitsInOrder([
            LoginState.loading(),
            LoginState.error(
              NetworkExceptions.getErrorMessage(
                  NetworkExceptions.internalServerError()),
            )
          ]));
      container
          .read(loginViewModelProvider.notifier)
          .login('email', 'password');
    });
  });
}
