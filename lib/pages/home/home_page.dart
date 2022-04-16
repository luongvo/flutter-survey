import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/pages/home/home_footer.dart';
import 'package:flutter_survey/pages/home/home_header.dart';
import 'package:flutter_survey/pages/home/home_state.dart';
import 'package:flutter_survey/pages/home/home_view_model.dart';
import 'package:flutter_survey/pages/home/survey_page_viewer.dart';
import 'package:flutter_survey/resources/dimens.dart';
import 'package:flutter_survey/usecase/get_surveys_use_case.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>((ref) {
  return HomeViewModel(getIt.get<GetSurveysUseCase>());
});

class HomePage extends ConsumerStatefulWidget {
  @override
  _HomePageState createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends ConsumerState<HomePage> {
  // TODO fetch survey list https://github.com/luongvo/flutter-survey/issues/14
  final _surveys = [1, 2, 3];
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    ref.listen<HomeState>(homeViewModelProvider, (_, homeState) {
      homeState.maybeWhen(
        error: (error) {
          // TODO
        },
        success: () async {
          // TODO
        },
        orElse: () {},
      );
    });
    return _buildHomePage();
  }

  Widget _buildHomePage() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          SurveyPageViewer(
            surveys: _surveys,
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
                    surveys: _surveys,
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
