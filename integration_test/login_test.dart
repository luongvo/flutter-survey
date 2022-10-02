import 'package:flutter/widgets.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/api/oauth_service.dart';
import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_survey/api/user_service.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/local/database/hive.dart';
import 'package:flutter_survey/main.dart';
import 'package:flutter_survey/pages/login/login_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'fake/fake_data.dart';
import 'fake/fake_oauth_service.dart';
import 'fake/fake_survey_service.dart';
import 'fake/fake_user_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Test', () {
    late Finder emailField;
    late Finder passwordField;
    late Finder loginButton;

    ProviderScope _prepareTestApp() {
      return ProviderScope(
        child: SurveyApp(),
      );
    }

    setUpAll(() async {
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
    });

    setUp(() {
      emailField = find.byKey(LoginPageKey.tfEmail);
      passwordField = find.byKey(LoginPageKey.tfPassword);
      loginButton = find.byKey(LoginPageKey.btLogin);
    });

    testWidgets(
        "When login with invalid email or password, it returns error message",
        (WidgetTester tester) async {
      FakeData.updateResponse(LOGIN_KEY, FakeResponse(400, {}));
      await tester.pumpWidget(_prepareTestApp());
      await tester.pumpAndSettle();

      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(loginButton, findsOneWidget);

      await tester.enterText(emailField, 'test@abc.com');
      await tester.enterText(passwordField, '12345678');

      await tester.tap(loginButton);
      await tester.pump(Duration(milliseconds: 200));

      await tester.pumpAndSettle();

      expect(find.text('Login failed! Please recheck your email or password'),
          findsOneWidget);
    });
  });
}
