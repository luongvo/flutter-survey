import 'dart:async';

import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/repository/oauth_repository.dart';
import 'package:flutter_survey/local/shared_preference_helper.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class LogoutUseCase extends NoParamsUseCase<void> {
  final OAuthRepository _repository;
  final SharedPreferencesHelper _sharedPreferencesHelper;

  const LogoutUseCase(this._repository, this._sharedPreferencesHelper);

  @override
  Future<Result<void>> call() async {
    final token = await _sharedPreferencesHelper.getAccessToken();
    return _repository
        .logout(token: token)
        .then((value) => _persistTokenData())
        .onError<NetworkExceptions>(
            (err, stackTrace) => Failed(UseCaseException(err)));
  }

  Result<dynamic> _persistTokenData() {
    _sharedPreferencesHelper.clear();
    return Success(null);
  }
}
