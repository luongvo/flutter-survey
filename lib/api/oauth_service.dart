import 'package:dio/dio.dart';
import 'package:flutter_survey/api/request/oauth_logout_request.dart';
import 'package:flutter_survey/api/request/oauth_token_request.dart';
import 'package:flutter_survey/api/response/oauth_token_response.dart';
import 'package:retrofit/retrofit.dart';

part 'oauth_service.g.dart';

@RestApi()
abstract class OAuthService {
  factory OAuthService(Dio dio, {String baseUrl}) = _OAuthService;

  @POST('/v1/oauth/token')
  Future<OAuthTokenResponse> login(
    @Body() OAuthTokenRequest body,
  );

  @POST('/v1/oauth/revoke')
  Future<void> logout(@Body() OAuthLogoutRequest body);
}
