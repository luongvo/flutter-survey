import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/oauth_service.dart';
import 'package:flutter_survey/api/request/oauth_token_request.dart';
import 'package:flutter_survey/env.dart';
import 'package:flutter_survey/models/oauth_token.dart';
import 'package:injectable/injectable.dart';

abstract class OauthRepository {
  Future<OAuthToken> login({
    required String email,
    required String password,
  });
}

@Singleton(as: OauthRepository)
class OauthRepositoryImpl extends OauthRepository {
  late OauthService _oauthService;

  OauthRepositoryImpl(this._oauthService);

  @override
  Future<OAuthToken> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _oauthService
          .login(OauthTokenRequest(
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
