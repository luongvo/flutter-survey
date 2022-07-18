import 'package:dio/dio.dart';
import 'package:flutter_survey/api/response/user_response.dart';
import 'package:retrofit/retrofit.dart';

part 'user_service.g.dart';

class SurveyApi {
  SurveyApi._();
}

@RestApi()
abstract class UserService {
  factory UserService(Dio dio, {String baseUrl}) = _UserService;

  @GET('/v1/me')
  Future<UserResponse> getUserProfile();
}
