import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/models/question.dart';
import 'package:flutter_survey/pages/surveydetail/survey_detail_state.dart';
import 'package:flutter_survey/pages/surveydetail/survey_detail_view_model.dart';
import 'package:flutter_survey/pages/surveydetail/widget/survey_question.dart';
import 'package:flutter_survey/pages/surveydetail/widget/survey_start.dart';
import 'package:flutter_survey/pages/uimodel/survey_ui_model.dart';
import 'package:flutter_survey/pages/widgets/dimmed_background.dart';
import 'package:flutter_survey/usecase/get_survey_detail_use_case.dart';

final surveyDetailViewModelProvider =
    StateNotifierProvider.autoDispose<SurveyDetailViewModel, SurveyDetailState>(
        (ref) {
  return SurveyDetailViewModel(getIt.get<GetSurveyDetailUseCase>());
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
  final PageController pageController = PageController(initialPage: 0);

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
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uiModel = ref.watch(_surveyStreamProvider).value;
    return ref.watch(surveyDetailViewModelProvider).when(
          init: () => const SizedBox.shrink(),
          loading: () => const SizedBox.shrink(),
          success: () => _buildSurveyPage(uiModel),
          error: (message) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(message ?? context.localization.errorGeneric)));
            });
            return _buildSurveyPage(uiModel);
          },
        );
  }

  Widget _buildSurveyPage(SurveyUiModel? survey) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: survey != null
          ? Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.network(survey.coverImageUrl).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                DimmedBackground(
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.7),
                  ],
                  stops: const [0.0, 1.0],
                ),
                _buildSurveyQuestionPager(survey)
              ],
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildSurveyQuestionPager(SurveyUiModel survey) {
    return PageView.builder(
      // TODO disable swiping https://github.com/luongvo/flutter-survey/issues/19
      // physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      itemCount: 5,
      itemBuilder: (context, i) => i == 0
          ? SurveyStart(survey: survey)
          : SurveyQuestion(displayType: DisplayType.dropdown),
    );
  }
}
