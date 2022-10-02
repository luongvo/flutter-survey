import 'package:flutter/widgets.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/local/database/hive.dart';
import 'package:flutter_survey/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Test', () {
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
    });

    testWidgets('Test Login screen ui', (tester) async {
      await tester.pumpWidget(_prepareTestApp());

      final Finder emailField = find.byKey(Key('tfLoginEmail'));
      final Finder passwordField = find.byKey(Key('tfLoginPassword'));
      final Finder submitBtn = find.byKey(Key('btLogin'));
      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(submitBtn, findsOneWidget);
    });
  });
}
