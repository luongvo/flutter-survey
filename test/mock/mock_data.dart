import 'package:dio/dio.dart';
import 'package:flutter_survey/api/oauth_service.dart';
import 'package:flutter_survey/api/repository/oauth_repository.dart';
import 'package:flutter_survey/api/repository/survey_repository.dart';
import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_survey/models/question.dart';
import 'package:flutter_survey/models/survey.dart';
import 'package:flutter_survey/models/survey_detail.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/get_survey_detail_use_case.dart';
import 'package:flutter_survey/usecase/get_surveys_use_case.dart';
import 'package:flutter_survey/usecase/login_use_case.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  OAuthService,
  SurveyService,
  OAuthRepository,
  SurveyRepository,
  LoginUseCase,
  GetSurveysUseCase,
  GetSurveyDetailUseCase,
  Survey,
  SurveyDetail,
  Question,
  UseCaseException,
  DioError
])
void main() {}
