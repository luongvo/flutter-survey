import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/pages/resetpassword/reset_password_page.dart';
import 'package:flutter_survey/pages/resetpassword/reset_password_state.dart';
import 'package:flutter_survey/pages/resetpassword/reset_password_view_model.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test/mock/mock_data.mocks.dart';

void main() {
  group('ResetPasswordViewModelTest', () {
    late MockResetPasswordUseCase mockResetPasswordUseCase;
    late ProviderContainer container;

    setUp(() {
      mockResetPasswordUseCase = MockResetPasswordUseCase();
      container = ProviderContainer(
        overrides: [
          resetPasswordViewModelProvider.overrideWithValue(
              ResetPasswordViewModel(mockResetPasswordUseCase)),
        ],
      );
      addTearDown(container.dispose);
    });

    test('When initializing, it initializes with Init state', () {
      expect(container.read(resetPasswordViewModelProvider),
          ResetPasswordState.init());
    });

    test(
        'When calling reset password with positive result, it returns Success state',
        () {
      when(mockResetPasswordUseCase.call(any))
          .thenAnswer((_) async => Success(null));
      final stateStream =
          container.read(resetPasswordViewModelProvider.notifier).stream;
      expect(
          stateStream,
          emitsInOrder(
              [ResetPasswordState.loading(), ResetPasswordState.success()]));
      container
          .read(resetPasswordViewModelProvider.notifier)
          .resetPassword('email');
    });

    test(
        'When calling reset password with negative result, it returns Failed state accordingly',
        () {
      final mockException = MockUseCaseException();
      when(mockException.actualException)
          .thenReturn(NetworkExceptions.internalServerError());
      when(mockResetPasswordUseCase.call(any))
          .thenAnswer((_) async => Failed(mockException));
      final stateStream =
          container.read(resetPasswordViewModelProvider.notifier).stream;
      expect(
          stateStream,
          emitsInOrder([
            ResetPasswordState.loading(),
            ResetPasswordState.error(
              NetworkExceptions.getErrorMessage(
                  NetworkExceptions.internalServerError()),
            )
          ]));
      container
          .read(resetPasswordViewModelProvider.notifier)
          .resetPassword('email');
    });
  });
}
