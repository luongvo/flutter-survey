import 'package:dio/dio.dart';
import 'package:flutter_survey/api/request/oauth_token_request.dart';
import 'package:flutter_survey/api/response/base/base_http_response.dart';
import 'package:flutter_survey/api/response/oauth_token_response.dart';
import 'package:retrofit/retrofit.dart';

part 'oauth_service.g.dart';

@RestApi()
abstract class OAuthService {
  factory OAuthService(Dio dio, {String baseUrl}) = _OAuthService;

  @POST('/v1/oauth/token')
  Future<BaseHttpResponse<OAuthTokenResponse>> login(
    @Body() OAuthTokenRequest body,
  );
}
