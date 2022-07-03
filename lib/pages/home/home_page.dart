import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/pages/home/home_footer.dart';
import 'package:flutter_survey/pages/home/home_header.dart';
import 'package:flutter_survey/pages/home/home_state.dart';
import 'package:flutter_survey/pages/home/home_view_model.dart';
import 'package:flutter_survey/pages/home/survey_page_viewer.dart';
import 'package:flutter_survey/pages/uimodel/survey_ui_model.dart';
import 'package:flutter_survey/resources/dimens.dart';
import 'package:flutter_survey/usecase/get_surveys_use_case.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>((ref) {
  return HomeViewModel(getIt.get<GetSurveysUseCase>());
});

final _uiModelsStreamProvider = StreamProvider.autoDispose<List<SurveyUiModel>>(
    (ref) => ref.watch(homeViewModelProvider.notifier).surveyUiModelsStream);

class HomePage extends ConsumerStatefulWidget {
  @override
  _HomePageState createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends ConsumerState<HomePage> {
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final uiModels = ref.watch(_uiModelsStreamProvider).value;
    return ref.watch(homeViewModelProvider).when(
          init: () => const SizedBox.shrink(),
          loading: () {
            // TODO https://github.com/luongvo/flutter-survey/issues/12
            return SizedBox.shrink();
          },
          success: () => _buildHomePage(uiModels ?? []),
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(message ?? context.localization.errorGeneric)));
            return _buildHomePage(uiModels ?? []);
          },
        );
  }

  Widget _buildHomePage(List<SurveyUiModel> surveys) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          SurveyPageViewer(
            surveys: surveys,
            currentPageNotifier: _currentPageNotifier,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.defaultMarginPadding),
              child: Column(
                children: [
                  HomeHeader(),
                  Expanded(
                    child: const SizedBox.shrink(),
                  ),
                  HomeFooter(
                    surveys: surveys,
                    currentPageNotifier: _currentPageNotifier,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
