import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'oauth_service.g.dart';

@RestApi()
abstract class OauthService {
  factory OauthService(Dio dio, {String baseUrl}) = _OauthService;
}
