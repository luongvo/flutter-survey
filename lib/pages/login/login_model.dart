import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/pages/login/login_state.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/login_use_case.dart';

class LoginModel extends StateNotifier<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginModel(this._loginUseCase) : super(const LoginState.init());

  Future<void> login(String email, String password) async {
    state = LoginState.loading();
    Result<void> result =
        await _loginUseCase.call(LoginInput(email: email, password: password));
    if (result is Success) {
      state = LoginState.success();
    } else {
      String? error;
      if ((result as Failed).exception.networkExceptions !=
          NetworkExceptions.unauthorisedRequest()) {
        error = NetworkExceptions.getErrorMessage(
            result.exception.networkExceptions);
      }
      state = LoginState.error(error);
    }
  }
}
