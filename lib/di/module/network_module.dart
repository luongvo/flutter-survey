import 'package:flutter_survey/api/oauth_service.dart';
import 'package:flutter_survey/di/provider/dio_provider.dart';
import 'package:flutter_survey/env.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @singleton
  OauthService provideOauthService(DioProvider dioProvider) {
    return OauthService(
      dioProvider.getNonAuthenticatedDio(),
      baseUrl: Env.restApiEndpoint,
    );
  }
}
