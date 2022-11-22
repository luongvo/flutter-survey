import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/api/oauth_service.dart';
import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_survey/api/user_service.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/local/database/hive.dart';
import 'package:flutter_survey/resources/app_theme.dart';

import '../fake/fake_oauth_service.dart';
import '../fake/fake_survey_service.dart';
import '../fake/fake_user_service.dart';

class TestUtil {
  TestUtil._();

  static ProviderScope prepareTestApp(
    Widget homeWidget, {
    Map<String, WidgetBuilder> routes = const {},
  }) {
    return ProviderScope(
      child: MaterialApp(
        theme: AppTheme.light,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: homeWidget,
        routes: routes,
      ),
    );
  }

  static Future<void> prepareTestEnv() async {
    FlutterConfig.loadValueForTesting({
      'REST_API_ENDPOINT': 'REST_API_ENDPOINT',
      'BASIC_AUTH_CLIENT_ID': 'CLIENT_ID',
      'BASIC_AUTH_CLIENT_SECRET': 'CLIENT_SECRET',
    });

    await initHive();
    await configureInjection();

    getIt.allowReassignment = true;
    getIt.registerSingleton<BaseOAuthService>(FakeOAuthService());
    getIt.registerSingleton<BaseUserService>(FakeUserService());
    getIt.registerSingleton<BaseSurveyService>(FakeSurveyService());
  }
}
