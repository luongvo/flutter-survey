import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/pages/login/login_state.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/login_use_case.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase) : super(const LoginState.init());

  Future<void> login(String email, String password) async {
    state = LoginState.loading();
    Result<void> result =
        await _loginUseCase.call(LoginInput(email: email, password: password));
    if (result is Success) {
      state = LoginState.success();
    } else {
      _handleError(result as Failed);
    }
  }

  _handleError(Failed result) {
    state = LoginState.error(result.getErrorMessage());
  }
}
