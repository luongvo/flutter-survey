import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/pages/surveydetail/survey_detail_state.dart';
import 'package:flutter_survey/pages/surveydetail/survey_detail_view_model.dart';
import 'package:flutter_survey/pages/surveydetail/widget/survey_question.dart';
import 'package:flutter_survey/pages/surveydetail/widget/survey_start.dart';
import 'package:flutter_survey/pages/uimodel/survey_ui_model.dart';
import 'package:flutter_survey/pages/widgets/dimmed_image_background.dart';
import 'package:flutter_survey/pages/widgets/loading_indicator.dart';
import 'package:flutter_survey/usecase/get_survey_detail_use_case.dart';
import 'package:flutter_survey/usecase/submit_survey_use_case.dart';

const Duration _pageScrollDuration = Duration(milliseconds: 200);

final surveyDetailViewModelProvider =
    StateNotifierProvider.autoDispose<SurveyDetailViewModel, SurveyDetailState>(
        (ref) {
  return SurveyDetailViewModel(
    getIt.get<GetSurveyDetailUseCase>(),
    getIt.get<SubmitSurveyUseCase>(),
  );
});

final _surveyStreamProvider = StreamProvider.autoDispose<SurveyUiModel>(
    (ref) => ref.watch(surveyDetailViewModelProvider.notifier).surveyStream);

class SurveyDetailPage extends ConsumerStatefulWidget {
  @override
  _SurveyDetailPageState createState() {
    return new _SurveyDetailPageState();
  }
}

class _SurveyDetailPageState extends ConsumerState<SurveyDetailPage> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final survey = context.arguments as SurveyUiModel;
      ref.read(surveyDetailViewModelProvider.notifier).loadSurveyDetail(survey);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uiModel = ref.watch(_surveyStreamProvider).value;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ref.watch(surveyDetailViewModelProvider).when(
            init: () => const SizedBox.shrink(),
            loading: () => LoadingIndicator(),
          success: () => _buildSurveyPage(uiModel),
          submitted: () {
            // TODO navigate to Completion screen https://github.com/luongvo/flutter-survey/issues/22
            context.navigateBack();
            return const SizedBox.shrink();
            },
            error: (message) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text(message ?? context.localization.errorGeneric)));
              });
              return _buildSurveyPage(uiModel);
            },
          ),
    );
  }

  Widget _buildSurveyPage(SurveyUiModel? survey) {
    return survey != null
        ? Stack(
            children: [
              DimmedImageBackground(
                image: Image.network(survey.coverImageUrl).image,
              ),
              SafeArea(child: _buildSurveyQuestionPager(survey)),
            ],
          )
        : const SizedBox.shrink();
  }

  Widget _buildSurveyQuestionPager(SurveyUiModel survey) {
    final pages = List.empty(growable: true);
    pages.add(
      SurveyStart(
        survey: survey,
        onNext: () => _gotoNextPage(),
      ),
    );
    pages.addAll(survey.questions
        .map((question) => SurveyQuestion(
              question: question,
              index: survey.questions.indexOf(question) + 1,
              total: survey.questions.length,
              onNext: () => _gotoNextPage(),
              onSubmit: () => _submitSurvey(),
            ))
        .toList());

    return PageView.builder(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      itemCount: pages.length,
      itemBuilder: (context, i) => pages[i],
    );
  }

  void _gotoNextPage() {
    _pageController.nextPage(
      duration: _pageScrollDuration,
      curve: Curves.ease,
    );
  }

  void _submitSurvey() {
    ref.read(surveyDetailViewModelProvider.notifier).submitSurvey();
  }
}
