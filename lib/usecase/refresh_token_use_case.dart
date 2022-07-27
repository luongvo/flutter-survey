import 'package:clock/clock.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/repository/oauth_repository.dart';
import 'package:flutter_survey/local/shared_preference_helper.dart';
import 'package:flutter_survey/models/oauth_token.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RefreshTokenUseCase extends NoParamsUseCase<OAuthToken> {
  final OAuthRepository _repository;
  final SharedPreferencesHelper _sharedPreferencesHelper;

  const RefreshTokenUseCase(
    this._repository,
    this._sharedPreferencesHelper,
  );

  @override
  Future<Result<OAuthToken>> call() async {
    final refreshToken = await _sharedPreferencesHelper.getRefreshToken();
    return _repository
        .refreshToken(refreshToken: refreshToken)
        .then((value) => _persistTokenData(value))
        .onError<NetworkExceptions>(
            (err, stackTrace) => Failed(UseCaseException(err)));
  }

  Result<OAuthToken> _persistTokenData(OAuthToken data) {
    _sharedPreferencesHelper.saveTokenType(data.tokenType);
    _sharedPreferencesHelper.saveAccessToken(data.accessToken);
    _sharedPreferencesHelper.saveRefreshToken(data.refreshToken);

    _sharedPreferencesHelper.saveTokenExpiration(
        data.expiresIn * 1000 + clock.now().millisecondsSinceEpoch);

    return Success(data);
  }
}
