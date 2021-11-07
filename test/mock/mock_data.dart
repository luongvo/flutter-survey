import 'package:dio/dio.dart';
import 'package:flutter_survey/api/oauth_service.dart';
import 'package:flutter_survey/api/repository/oauth_repository.dart';
import 'package:flutter_survey/api/repository/survey_repository.dart';
import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/login_use_case.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  OAuthService,
  SurveyService,
  OAuthRepository,
  SurveyRepository,
  LoginUseCase,
  UseCaseException,
  DioError
])
void main() {}
