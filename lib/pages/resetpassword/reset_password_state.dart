import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_state.freezed.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState.init() = _Init;

  const factory ResetPasswordState.loading() = _Loading;

  const factory ResetPasswordState.error(String? error) = _Error;

  const factory ResetPasswordState.success() = _Success;
}
