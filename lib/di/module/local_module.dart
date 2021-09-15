import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class LocalModule {
  @singleton
  @preResolve
  Future<SharedPreferences> get sharedPref => SharedPreferences.getInstance();
}
