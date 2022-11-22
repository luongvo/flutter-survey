import 'package:clock/clock.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_survey/extensions/date_time_ext.dart';
import 'package:flutter_survey/pages/home/home_page.dart';
import 'package:flutter_survey/pages/surveydetail/survey_detail_page.dart';
import 'package:flutter_survey/routes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'fake/fake_data.dart';
import 'fake/fake_survey_service.dart';
import 'fake/fake_user_service.dart';
import 'utils/file_util.dart';
import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Home Page Test', () {
    late Map<String, dynamic> surveysJson;
    late Map<String, dynamic> userJson;

    setUpAll(() async {
      await TestUtil.prepareTestEnv();
    });

    setUp(() async {
      surveysJson = await FileUtil.loadFile('test_resources/surveys.json');
      userJson = await FileUtil.loadFile('test_resources/user.json');
    });

    testWidgets("When starting, it displays correct info and user name",
        (WidgetTester tester) async {
      await tester.pumpWidget(TestUtil.prepareTestApp(HomePage()));
      await tester.pumpAndSettle();

      expect(find.text(clock.now().toFormattedFullDayMonthYear().toUpperCase()),
          findsOneWidget);
      expect(find.text("Today"), findsOneWidget);
    });

    testWidgets(
        "When loading surveys successfully, it shows correct survey data",
        (WidgetTester tester) async {
      FakeData.addSuccessResponse(SURVEYS_KEY, surveysJson);
      FakeData.addSuccessResponse(USER_KEY, userJson);
      await tester.pumpWidget(TestUtil.prepareTestApp(HomePage()));
      await tester.pumpAndSettle();

      // Verify first survey page
      final survey1 = surveysJson['data'][0];
      expect(find.text(survey1['title']), findsOneWidget);
      expect(find.text(survey1['description']), findsOneWidget);

      // Swipe to next page
      await tester.flingFrom(Offset(100, 300), Offset(-100, 0), 500);
      await tester.pumpAndSettle();

      // Verify second survey page
      final survey2 = surveysJson['data'][1];
      expect(find.text(survey2['title']), findsOneWidget);
      expect(find.text(survey2['description']), findsOneWidget);
    });

    testWidgets(
        "When clicking on Start survey button, it navigates to Survey Detail page",
        (WidgetTester tester) async {
      FakeData.addSuccessResponse(USER_KEY, userJson);
      await tester.pumpWidget(TestUtil.prepareTestApp(
        HomePage(),
        routes: <String, WidgetBuilder>{
          Routes.survey: (BuildContext context) => SurveyDetailPage(),
        },
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(HomePageKey.btStartSurvey));
      await tester.pumpAndSettle();

      expect(find.byType(SurveyDetailPage), findsOneWidget);
    });

    testWidgets(
        "When clicking on the user profile avatar, it opens the drawer with correct user name",
        (WidgetTester tester) async {
      FakeData.addSuccessResponse(USER_KEY, userJson);
      await tester.pumpWidget(TestUtil.prepareTestApp(
        HomePage(),
        routes: <String, WidgetBuilder>{
          Routes.survey: (BuildContext context) => SurveyDetailPage(),
        },
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(HomePageKey.ivAvatar));
      await tester.pumpAndSettle();

      expect(find.text(userJson['data']['name']), findsOneWidget);
    });
  });
}
