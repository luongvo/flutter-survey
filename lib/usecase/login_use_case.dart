import 'dart:async';

import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/repository/oauth_repository.dart';
import 'package:flutter_survey/local/shared_preference_helper.dart';
import 'package:flutter_survey/models/oauth_token.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:injectable/injectable.dart';

class LoginInput {
  final String email;
  final String password;

  LoginInput({required this.email, required this.password});
}

@Injectable()
class LoginUseCase extends UseCase<void, LoginInput> {
  final OauthRepository _repository;
  final SharedPreferencesHelper _sharedPreferencesHelper;

  const LoginUseCase(this._repository, this._sharedPreferencesHelper);

  @override
  Future<Result<void>> call(LoginInput input) {
    return _repository
        .login(email: input.email, password: input.password)
        .then((value) => _persistTokenData(value))
        .onError<NetworkExceptions>(
            (err, stackTrace) => Failed(UseCaseException(err, null)));
  }

  Result<dynamic> _persistTokenData(OAuthToken data) {
    _sharedPreferencesHelper.saveTokenType(data.tokenType);
    _sharedPreferencesHelper.saveAccessToken(data.accessToken);
    _sharedPreferencesHelper.saveRefreshToken(data.refreshToken);

    _sharedPreferencesHelper.saveTokenExpiration(
        data.expiresIn * 1000 + DateTime.now().millisecondsSinceEpoch);

    return Success(null);
  }
}
