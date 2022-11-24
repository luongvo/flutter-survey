import 'package:flutter/material.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/pages/completion/completion_page.dart';
import 'package:flutter_survey/pages/home/home_page.dart';
import 'package:flutter_survey/pages/surveydetail/page/survey_answer.dart';
import 'package:flutter_survey/pages/surveydetail/survey_detail_page.dart';
import 'package:flutter_survey/pages/surveydetail/widget/circular_checkbox.dart';
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
          Routes.completion: (BuildContext context) => CompletionPage(),
          Routes.home: (BuildContext context) => HomePage(),
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

      // Verify the first Start page
      expect(find.text(surveyJson['data']['title']), findsOneWidget);
      expect(find.text(surveyJson['data']['description']), findsOneWidget);
      expect(find.byKey(SurveyDetailPageKey.btBack), findsOneWidget);
      expect(find.byKey(SurveyDetailPageKey.btStart), findsOneWidget);
    });

    testWidgets(
        "When clicking on the Back button on the Start page, it navigates back to Home page",
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

    testWidgets(
        "When navigating to the question list pages, it shows each question page with corresponding questions and answer forms",
        (WidgetTester tester) async {
      // Open Survey Detail
      await tester.pumpWidget(homeScreenWidget);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(HomePageKey.btStartSurvey));
      await tester.pumpAndSettle();

      // Click Start Survey
      await tester.tap(find.byKey(SurveyDetailPageKey.btStart));
      await tester.pumpAndSettle();

      // First question
      final firstQuestion = surveyJson['data']['questions'][0];
      expect(find.text(firstQuestion['text']), findsOneWidget);
    });

    testWidgets(
        "When clicking on Close button, it navigates back to the Home page",
        (WidgetTester tester) async {
      // Open Survey Detail
      await tester.pumpWidget(homeScreenWidget);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(HomePageKey.btStartSurvey));
      await tester.pumpAndSettle();

      // Click Start Survey
      await tester.tap(find.byKey(SurveyDetailPageKey.btStart));
      await tester.pumpAndSettle();

      // Click Close
      await tester.tap(find.byKey(SurveyDetailPageKey.btClose));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets(
        "When answering all questions and submitting survey successfully, it navigates to the Complete Page then automatically returning to the Home page",
        (WidgetTester tester) async {
      // Open Survey Detail
      await tester.pumpWidget(homeScreenWidget);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(HomePageKey.btStartSurvey));
      await tester.pumpAndSettle();

      // Click Start Survey
      await tester.tap(find.byKey(SurveyDetailPageKey.btStart));
      await tester.pumpAndSettle();

      FakeData.addSuccessResponse(SUBMIT_SURVEY_KEY, {});
      await _answerAllQuestions(tester);

      // Wait a bit for the animation
      await tester.pump(Duration(milliseconds: 500));

      expect(find.byType(CompletionPage), findsOneWidget);
      expect(find.text("Thanks for taking \u2028the survey."), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets(
        "When answering all questions and submitting survey failed, it shows error properly",
        (WidgetTester tester) async {
      // Open Survey Detail
      await tester.pumpWidget(homeScreenWidget);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(HomePageKey.btStartSurvey));
      await tester.pumpAndSettle();

      // Click Start Survey
      await tester.tap(find.byKey(SurveyDetailPageKey.btStart));
      await tester.pumpAndSettle();

      FakeData.addErrorResponse(SUBMIT_SURVEY_KEY);
      await _answerAllQuestions(tester);

      await tester.pumpAndSettle();

      final errorMessage =
          NetworkExceptions.getErrorMessage(NetworkExceptions.badRequest()) ??
              '';
      expect(find.text(errorMessage), findsOneWidget);
    });
  });
}

Future<void> _answerAllQuestions(WidgetTester tester) async {
  // 1st question: Intro
  await tester.tap(find.byKey(SurveyDetailPageKey.btQuestionNext));
  await tester.pumpAndSettle();

  // 2nd question: Rating
  await tester.tapAt(tester.getCenter(find.byType(SurveyAnswer)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(SurveyDetailPageKey.btQuestionNext));
  await tester.pumpAndSettle();

  // 3rd question: Rating
  await tester.tapAt(tester.getCenter(find.byType(SurveyAnswer)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(SurveyDetailPageKey.btQuestionNext));
  await tester.pumpAndSettle();

  // 4th question: Rating
  await tester.tapAt(tester.getCenter(find.byType(SurveyAnswer)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(SurveyDetailPageKey.btQuestionNext));
  await tester.pumpAndSettle();

  // 5th question: Rating
  await tester.tapAt(tester.getCenter(find.byType(SurveyAnswer)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(SurveyDetailPageKey.btQuestionNext));
  await tester.pumpAndSettle();

  // 6th question: Rating
  await tester.tapAt(tester.getCenter(find.byType(SurveyAnswer)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(SurveyDetailPageKey.btQuestionNext));
  await tester.pumpAndSettle();

  // 7th question: Smiley
  await tester.tap(find.byKey(SurveyDetailPageKey.btQuestionNext));
  await tester.pumpAndSettle();

  // 8th question: Multi choice
  await tester.tap(find.byType(CircularCheckBox).first);
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(SurveyDetailPageKey.btQuestionNext));
  await tester.pumpAndSettle();

  // 9th question: Number rating
  await tester.tap(find.text('8'));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(SurveyDetailPageKey.btQuestionNext));
  await tester.pumpAndSettle();

  // 10th question: Text area
  await tester.enterText(find.byType(TextFormField), 'test');
  await tester.pump(Duration(milliseconds: 100));
  await tester.tap(find.byKey(SurveyDetailPageKey.btQuestionNext));
  await tester.pumpAndSettle();

  // 11th question: Text fields
  await tester.enterText(find.byType(TextFormField).at(0), 'test');
  await tester.pump(Duration(milliseconds: 100));
  await tester.enterText(find.byType(TextFormField).at(1), 'test');
  await tester.pump(Duration(milliseconds: 100));
  await tester.enterText(find.byType(TextFormField).at(2), 'test');
  await tester.pump(Duration(milliseconds: 100));
  await tester.tap(find.byKey(SurveyDetailPageKey.btQuestionNext));
  await tester.pumpAndSettle();

  // 12th question: Outro
  expect(find.byKey(SurveyDetailPageKey.btQuestionSubmit), findsOneWidget);

  // Submit
  await tester.tap(find.byKey(SurveyDetailPageKey.btQuestionSubmit));
}
