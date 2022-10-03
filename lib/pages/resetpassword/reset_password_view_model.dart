import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/pages/resetpassword/reset_password_state.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/reset_password_use_case.dart';

class ResetPasswordViewModel extends StateNotifier<ResetPasswordState> {
  final ResetPasswordUseCase _resetPasswordUseCase;

  ResetPasswordViewModel(this._resetPasswordUseCase)
      : super(const ResetPasswordState.init());

  Future<void> resetPassword(String email) async {
    state = ResetPasswordState.loading();
    Result<void> result = await _resetPasswordUseCase.call(email);
    if (result is Success) {
      state = ResetPasswordState.success();
    } else {
      _handleError(result as Failed);
    }
  }

  _handleError(Failed result) {
    state = ResetPasswordState.error(result.getErrorMessage());
  }
}
