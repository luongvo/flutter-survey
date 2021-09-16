import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/oauth_service.dart';
import 'package:flutter_survey/api/request/oauth_token_request.dart';
import 'package:flutter_survey/env.dart';
import 'package:flutter_survey/models/oauth_token.dart';
import 'package:injectable/injectable.dart';

abstract class OAuthRepository {
  Future<OAuthToken> login({
    required String email,
    required String password,
  });
}

@Singleton(as: OAuthRepository)
class OAuthRepositoryImpl extends OAuthRepository {
  late OAuthService _oauthService;

  OAuthRepositoryImpl(this._oauthService);

  @override
  Future<OAuthToken> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _oauthService
          .login(OAuthTokenRequest(
            email: email,
            password: password,
            clientId: Env.basicAuthClientId,
            clientSecret: Env.basicAuthClientSecret,
          ))
          .then((response) => response.data.attributes);
      return OAuthToken(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        tokenType: response.tokenType,
        expiresIn: response.expiresIn,
      );
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
