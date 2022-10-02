import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/oauth_service.dart';
import 'package:flutter_survey/api/request/oauth_logout_request.dart';
import 'package:flutter_survey/api/request/oauth_refresh_token_request.dart';
import 'package:flutter_survey/api/request/oauth_token_request.dart';
import 'package:flutter_survey/api/request/reset_password_request.dart';
import 'package:flutter_survey/env.dart';
import 'package:flutter_survey/models/oauth_token.dart';
import 'package:injectable/injectable.dart';

abstract class OAuthRepository {
  Future<OAuthToken> login({
    required String email,
    required String password,
  });

  Future<void> logout({
    required String token,
  });

  Future<OAuthToken> refreshToken({
    required String refreshToken,
  });

  Future<void> resetPassword({
    required String email,
  });
}

@LazySingleton(as: OAuthRepository)
class OAuthRepositoryImpl extends OAuthRepository {
  BaseOAuthService _oauthService;

  OAuthRepositoryImpl(this._oauthService);

  @override
  Future<OAuthToken> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _oauthService.login(OAuthTokenRequest(
        email: email,
        password: password,
        clientId: Env.basicAuthClientId,
        clientSecret: Env.basicAuthClientSecret,
      ));
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

  @override
  Future<void> logout({
    required String token,
  }) async {
    try {
      return await _oauthService.logout(OAuthLogoutRequest(
        token: token,
        clientId: Env.basicAuthClientId,
        clientSecret: Env.basicAuthClientSecret,
      ));
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

  @override
  Future<OAuthToken> refreshToken({required String refreshToken}) async {
    try {
      final response = await _oauthService.refreshToken(
        OAuthRefreshTokenRequest(
          clientId: Env.basicAuthClientId,
          clientSecret: Env.basicAuthClientSecret,
          refreshToken: refreshToken,
        ),
      );
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

  @override
  Future<void> resetPassword({
    required String email,
  }) async {
    try {
      await _oauthService.resetPassword(ResetPasswordRequest(
        user: UserRequest(
          email: email,
        ),
        clientId: Env.basicAuthClientId,
        clientSecret: Env.basicAuthClientSecret,
      ));
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
