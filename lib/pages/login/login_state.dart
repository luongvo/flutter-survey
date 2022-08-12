import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.init() = _Init;

  const factory LoginState.login() = _Login;

  const factory LoginState.loading() = _Loading;

  const factory LoginState.error(String? error) = _Error;

  const factory LoginState.success() = _Success;
}
