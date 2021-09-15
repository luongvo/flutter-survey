// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../api/oauth_service.dart' as _i7;
import '../api/repository/oauth_repository.dart' as _i4;
import '../local/shared_preference_helper.dart' as _i5;
import '../usecase/login_use_case.dart' as _i3;
import 'module/local_module.dart' as _i10;
import 'module/network_module.dart' as _i9;
import 'provider/dio_provider.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final networkModule = _$NetworkModule();
  final localModule = _$LocalModule();
  gh.factory<_i3.LoginUseCase>(() => _i3.LoginUseCase(
      get<_i4.OAuthRepository>(), get<_i5.SharedPreferencesHelper>()));
  gh.singleton<_i6.DioProvider>(_i6.DioProvider());
  gh.singleton<_i7.OAuthService>(
      networkModule.provideOAuthService(get<_i6.DioProvider>()));
  await gh.singletonAsync<_i8.SharedPreferences>(() => localModule.sharedPref,
      preResolve: true);
  gh.singleton<_i5.SharedPreferencesHelper>(
      _i5.SharedPreferencesHelperImpl(get<_i8.SharedPreferences>()));
  gh.singleton<_i4.OAuthRepository>(
      _i4.OAuthRepositoryImpl(get<_i7.OAuthService>()));
  return get;
}

class _$NetworkModule extends _i9.NetworkModule {}

class _$LocalModule extends _i10.LocalModule {}
