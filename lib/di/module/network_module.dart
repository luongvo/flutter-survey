import 'package:flutter_survey/api/oauth_service.dart';
import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_survey/api/user_service.dart';
import 'package:flutter_survey/di/provider/dio_provider.dart';
import 'package:flutter_survey/env.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @singleton
  OAuthService provideOAuthService(DioProvider dioProvider) {
    return OAuthService(
      dioProvider.getNonAuthenticatedDio(),
      baseUrl: Env.restApiEndpoint,
    );
  }

  @singleton
  SurveyService provideSurveyService(DioProvider dioProvider) {
    return SurveyService(
      dioProvider.getAuthenticatedDio(),
      baseUrl: Env.restApiEndpoint,
    );
  }

  @singleton
  UserService provideUserService(DioProvider dioProvider) {
    return UserService(
      dioProvider.getAuthenticatedDio(),
      baseUrl: Env.restApiEndpoint,
    );
  }
}
