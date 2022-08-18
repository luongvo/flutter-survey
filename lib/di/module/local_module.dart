import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class LocalModule {
  @singleton
  @preResolve
  Future<SharedPreferences> get sharedPref => SharedPreferences.getInstance();

  @Named('surveyBox')
  @singleton
  @preResolve
  Future<Box> get surveyBox => Hive.openBox('survey');
}
