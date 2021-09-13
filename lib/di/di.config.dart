// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../api/oauth_service.dart' as _i6;
import '../api/repository/oauth_repository.dart' as _i4;
import '../usecase/login_use_case.dart' as _i3;
import 'module/network_module.dart' as _i7;
import 'provider/dio_provider.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final networkModule = _$NetworkModule();
  gh.factory<_i3.LoginUseCase>(
      () => _i3.LoginUseCase(get<_i4.OauthRepository>()));
  gh.singleton<_i5.DioProvider>(_i5.DioProvider());
  gh.singleton<_i6.OauthService>(
      networkModule.provideOauthService(get<_i5.DioProvider>()));
  gh.singleton<_i4.OauthRepository>(
      _i4.OauthRepositoryImpl(get<_i6.OauthService>()));
  return get;
}

class _$NetworkModule extends _i7.NetworkModule {}
