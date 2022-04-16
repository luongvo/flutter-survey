// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

import '../api/oauth_service.dart' as _i6;
import '../api/repository/oauth_repository.dart' as _i8;
import '../api/repository/survey_repository.dart' as _i9;
import '../api/survey_service.dart' as _i7;
import '../local/shared_preference_helper.dart' as _i4;
import '../usecase/get_surveys_use_case.dart' as _i10;
import '../usecase/login_use_case.dart' as _i11;
import 'module/local_module.dart' as _i12;
import 'module/network_module.dart' as _i13;
import 'provider/dio_provider.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final localModule = _$LocalModule();
  final networkModule = _$NetworkModule();
  await gh.singletonAsync<_i3.SharedPreferences>(() => localModule.sharedPref,
      preResolve: true);
  gh.singleton<_i4.SharedPreferencesHelper>(
      _i4.SharedPreferencesHelperImpl(get<_i3.SharedPreferences>()));
  gh.singleton<_i5.DioProvider>(
      _i5.DioProvider(get<_i4.SharedPreferencesHelper>()));
  gh.singleton<_i6.OAuthService>(
      networkModule.provideOAuthService(get<_i5.DioProvider>()));
  gh.singleton<_i7.SurveyService>(
      networkModule.provideSurveyService(get<_i5.DioProvider>()));
  gh.singleton<_i8.OAuthRepository>(
      _i8.OAuthRepositoryImpl(get<_i6.OAuthService>()));
  gh.singleton<_i9.SurveyRepository>(
      _i9.SurveyRepositoryImpl(get<_i7.SurveyService>()));
  gh.factory<_i10.GetSurveysUseCase>(
      () => _i10.GetSurveysUseCase(get<_i9.SurveyRepository>()));
  gh.factory<_i11.LoginUseCase>(() => _i11.LoginUseCase(
      get<_i8.OAuthRepository>(), get<_i4.SharedPreferencesHelper>()));
  return get;
}

class _$LocalModule extends _i12.LocalModule {}

class _$NetworkModule extends _i13.NetworkModule {}
