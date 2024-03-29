import 'package:dio/dio.dart';
import 'package:flutter_survey/api/request/oauth_logout_request.dart';
import 'package:flutter_survey/api/request/oauth_refresh_token_request.dart';
import 'package:flutter_survey/api/request/oauth_token_request.dart';
import 'package:flutter_survey/api/request/reset_password_request.dart';
import 'package:flutter_survey/api/response/oauth_token_response.dart';
import 'package:retrofit/retrofit.dart';

part 'oauth_service.g.dart';

abstract class BaseOAuthService {
  Future<OAuthTokenResponse> login(
    @Body() OAuthTokenRequest body,
  );

  Future<void> logout(@Body() OAuthLogoutRequest body);

  Future<OAuthTokenResponse> refreshToken(
    @Body() OAuthRefreshTokenRequest body,
  );

  Future<void> resetPassword(
    @Body() ResetPasswordRequest body,
  );
}

@RestApi()
abstract class OAuthService extends BaseOAuthService {
  factory OAuthService(Dio dio, {String baseUrl}) = _OAuthService;

  @POST('/v1/oauth/token')
  Future<OAuthTokenResponse> login(
    @Body() OAuthTokenRequest body,
  );

  @POST('/v1/oauth/revoke')
  Future<void> logout(@Body() OAuthLogoutRequest body);

  @POST('/v1/oauth/token')
  Future<OAuthTokenResponse> refreshToken(
    @Body() OAuthRefreshTokenRequest body,
  );

  @POST('/v1/passwords')
  Future<void> resetPassword(
    @Body() ResetPasswordRequest body,
  );
}
