import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  ProviderScope _prepareTestApp() {
    return ProviderScope(
      child: SurveyApp(),
    );
  }

  group('Login Test', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('Test Splash animation performance', (tester) async {
      await tester.pumpWidget(_prepareTestApp());

      await binding.watchPerformance(() async {},
          reportKey: 'animation_performance_summary');
    });
  });
}
