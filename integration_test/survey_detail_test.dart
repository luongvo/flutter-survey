import 'package:flutter/widgets.dart';
import 'package:flutter_survey/pages/home/home_page.dart';
import 'package:flutter_survey/pages/surveydetail/survey_detail_page.dart';
import 'package:flutter_survey/routes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'fake/fake_data.dart';
import 'fake/fake_survey_service.dart';
import 'utils/file_util.dart';
import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Survey Detail Page Test', () {
    late Map<String, dynamic> surveysJson;
    late Map<String, dynamic> surveyJson;
    late Widget homeScreenWidget;

    setUpAll(() async {
      await TestUtil.prepareTestEnv();
    });

    setUp(() async {
      surveysJson = await FileUtil.loadFile('test_resources/surveys.json');
      surveyJson = await FileUtil.loadFile('test_resources/survey_detail.json');

      FakeData.addSuccessResponse(SURVEYS_KEY, surveysJson);
      FakeData.addSuccessResponse(SURVEY_KEY, surveyJson);

      homeScreenWidget = TestUtil.prepareTestApp(
        HomePage(),
        routes: <String, WidgetBuilder>{
          Routes.survey: (BuildContext context) => SurveyDetailPage(),
        },
      );
    });

    testWidgets("When starting, it displays correct survey info",
        (WidgetTester tester) async {
      // Open Survey Detail
      await tester.pumpWidget(homeScreenWidget);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(HomePageKey.btStartSurvey));
      await tester.pumpAndSettle();

      expect(find.text(surveyJson['data']['title']), findsOneWidget);
      expect(find.text(surveyJson['data']['description']), findsOneWidget);
    });

    testWidgets(
        "When clicking on the Back button on the Start page, it navigates back to Home screen",
        (WidgetTester tester) async {
      // Open Survey Detail
      await tester.pumpWidget(homeScreenWidget);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(HomePageKey.btStartSurvey));
      await tester.pumpAndSettle();

      // Click back
      await tester.tap(find.byKey(SurveyDetailPageKey.btBack));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets(
        "When clicking on the Start Survey button, it navigates the next page to show question list",
        (WidgetTester tester) async {
      // Open Survey Detail
      await tester.pumpWidget(homeScreenWidget);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(HomePageKey.btStartSurvey));
      await tester.pumpAndSettle();

      // Click Start Survey
      await tester.tap(find.byKey(SurveyDetailPageKey.btStart));
      await tester.pumpAndSettle();

      expect(find.byKey(SurveyDetailPageKey.btClose), findsOneWidget);
      expect(find.byKey(SurveyDetailPageKey.btQuestionNext), findsOneWidget);
    });
  });
}
