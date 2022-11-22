import 'package:flutter/widgets.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_survey/pages/home/home_page.dart';
import 'package:flutter_survey/pages/login/login_page.dart';
import 'package:flutter_survey/routes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'fake/fake_data.dart';
import 'fake/fake_oauth_service.dart';
import 'utils/file_util.dart';
import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Page Test', () {
    late Map<String, dynamic> loginJson;

    late Finder tfEmail;
    late Finder tfPassword;
    late Finder btLogin;

    setUpAll(() async {
      FlutterConfig.loadValueForTesting({
        'REST_API_ENDPOINT': 'REST_API_ENDPOINT',
        'BASIC_AUTH_CLIENT_ID': 'CLIENT_ID',
        'BASIC_AUTH_CLIENT_SECRET': 'CLIENT_SECRET',
      });
      await TestUtil.prepareTestEnv();
    });

    setUp(() async {
      loginJson = await FileUtil.loadFile('test_resources/oauth_login.json');

      tfEmail = find.byKey(LoginPageKey.tfEmail);
      tfPassword = find.byKey(LoginPageKey.tfPassword);
      btLogin = find.byKey(LoginPageKey.btLogin);
    });

    testWidgets("When starting, it displays the Login screen correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(TestUtil.prepareTestApp(LoginPage()));

      await tester.pumpAndSettle();
      expect(tfEmail, findsOneWidget);
      expect(tfPassword, findsOneWidget);
      expect(btLogin, findsOneWidget);
    });

    testWidgets(
        "When logging with invalid email or password, it shows the error message",
        (WidgetTester tester) async {
      FakeData.addErrorResponse(LOGIN_KEY);
      await tester.pumpWidget(TestUtil.prepareTestApp(LoginPage()));

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
      FakeData.addSuccessResponse(LOGIN_KEY, loginJson);
      await tester.pumpWidget(TestUtil.prepareTestApp(
        LoginPage(),
        routes: <String, WidgetBuilder>{
          Routes.home: (BuildContext context) => HomePage()
        },
      ));

      await tester.pumpAndSettle();
      await tester.enterText(tfEmail, 'test@abc.com');
      await tester.enterText(tfPassword, '12345678');
      await tester.tap(btLogin);

      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
