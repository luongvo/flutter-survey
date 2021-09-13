import 'package:flutter_survey/api/oauth_service.dart';
import 'package:flutter_survey/api/request/oauth_token_request.dart';
import 'package:flutter_survey/api/response/oauth_token_response.dart';
import 'package:flutter_survey/env.dart';
import 'package:injectable/injectable.dart';

abstract class OauthRepository {
  Future<OauthTokenResponse> login({
    required String email,
    required String password,
  });
}

@Singleton(as: OauthRepository)
class OauthRepositoryImpl extends OauthRepository {
  late OauthService _oauthService;

  OauthRepositoryImpl(this._oauthService);

  @override
  Future<OauthTokenResponse> login({
    required String email,
    required String password,
  }) {
    return _oauthService
        .login(OauthTokenRequest(
          email: email,
          password: password,
          clientId: Env.basicAuthClientId,
          clientSecret: Env.basicAuthClientSecret,
        ))
        .then((response) => response.data.attributes);
  }
}
