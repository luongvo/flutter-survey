import 'package:dio/dio.dart';
import 'package:flutter_survey/api/oauth_service.dart';
import 'package:flutter_survey/api/repository/oauth_repository.dart';
import 'package:flutter_survey/api/repository/survey_repository.dart';
import 'package:flutter_survey/api/repository/user_repository.dart';
import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_survey/api/user_service.dart';
import 'package:flutter_survey/local/shared_preference_helper.dart';
import 'package:flutter_survey/local/database/survey_box_helper.dart';
import 'package:flutter_survey/models/question.dart';
import 'package:flutter_survey/models/survey.dart';
import 'package:flutter_survey/models/survey_detail.dart';
import 'package:flutter_survey/models/user.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/get_cache_surveys_use_case.dart';
import 'package:flutter_survey/usecase/get_survey_detail_use_case.dart';
import 'package:flutter_survey/usecase/get_surveys_use_case.dart';
import 'package:flutter_survey/usecase/get_user_profile_use_case.dart';
import 'package:flutter_survey/usecase/login_use_case.dart';
import 'package:flutter_survey/usecase/logout_use_case.dart';
import 'package:flutter_survey/usecase/submit_survey_use_case.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  OAuthService,
  SurveyService,
  UserService,
  OAuthRepository,
  SurveyRepository,
  UserRepository,
  LoginUseCase,
  GetSurveysUseCase,
  GetSurveyDetailUseCase,
  SubmitSurveyUseCase,
  GetUserProfileUseCase,
  LogoutUseCase,
  SharedPreferencesHelper,
  GetCacheSurveysUseCase,
  SurveyBoxHelper,
  Survey,
  SurveyDetail,
  Question,
  User,
  UseCaseException,
  DioError
])
void main() {}
