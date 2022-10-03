import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/api/oauth_service.dart';
import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_survey/api/user_service.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/local/database/hive.dart';
import 'package:flutter_survey/main.dart';
import 'package:flutter_survey/pages/home/home_page.dart';
import 'package:flutter_survey/pages/login/login_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'fake/fake_data.dart';
import 'fake/fake_oauth_service.dart';
import 'fake/fake_survey_service.dart';
import 'fake/fake_user_service.dart';
import 'utils/file_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Test', () {
    late Finder tfEmail;
    late Finder tfPassword;
    late Finder btLogin;

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
      tfEmail = find.byKey(LoginPageKey.tfEmail);
      tfPassword = find.byKey(LoginPageKey.tfPassword);
      btLogin = find.byKey(LoginPageKey.btLogin);
    });

    testWidgets("When starting, it displays the Login screen correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(_prepareTestApp());

      await tester.pumpAndSettle();
      expect(tfEmail, findsOneWidget);
      expect(tfPassword, findsOneWidget);
      expect(btLogin, findsOneWidget);
    });

    testWidgets(
        "When logging with invalid email or password, it shows the error message",
        (WidgetTester tester) async {
      FakeData.updateResponse(LOGIN_KEY, FakeResponse(400, {}));
      await tester.pumpWidget(_prepareTestApp());

      await tester.pumpAndSettle();
      await tester.enterText(tfEmail, 'test@abc.com');
      await tester.enterText(tfPassword, '12345678');
      await tester.tap(btLogin);

      await tester.pumpAndSettle();
      expect(find.text('Login failed! Please recheck your email or password'),
          findsOneWidget);
    });

    testWidgets(
        "When logging with valid email and password, it navigates to HomePage",
        (WidgetTester tester) async {
      FakeData.updateResponse(
          LOGIN_KEY,
          FakeResponse(
              200, await FileUtil.loadFile('test_resources/oauth_login.json')));
      await tester.pumpWidget(_prepareTestApp());

      await tester.pumpAndSettle();
      await tester.enterText(tfEmail, 'test@abc.com');
      await tester.enterText(tfPassword, '12345678');
      await tester.tap(btLogin);

      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
