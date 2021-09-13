// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../api/oauth_service.dart' as _i4;
import 'module/network_module.dart' as _i5;
import 'provider/dio_provider.dart'
    as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final networkModule = _$NetworkModule();
  gh.singleton<_i3.DioProvider>(_i3.DioProvider());
  gh.singleton<_i4.OauthService>(
      networkModule.provideOauthService(get<_i3.DioProvider>()));
  return get;
}

class _$NetworkModule extends _i5.NetworkModule {}
