import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/gen/colors.gen.dart';
import 'package:flutter_survey/models/user.dart';
import 'package:flutter_survey/pages/home/home_drawer.dart';
import 'package:flutter_survey/pages/home/home_header.dart';
import 'package:flutter_survey/pages/home/home_state.dart';
import 'package:flutter_survey/pages/home/home_view_model.dart';
import 'package:flutter_survey/pages/home/survey_page_viewer.dart';
import 'package:flutter_survey/pages/uimodel/survey_ui_model.dart';
import 'package:flutter_survey/pages/widgets/loading_indicator.dart';
import 'package:flutter_survey/resources/dimens.dart';
import 'package:flutter_survey/routes.dart';
import 'package:flutter_survey/usecase/get_cache_surveys_use_case.dart';
import 'package:flutter_survey/usecase/get_surveys_use_case.dart';
import 'package:flutter_survey/usecase/get_user_profile_use_case.dart';
import 'package:flutter_survey/usecase/logout_use_case.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>((ref) {
  return HomeViewModel(
    getIt.get<GetUserProfileUseCase>(),
    getIt.get<GetSurveysUseCase>(),
    getIt.get<GetCacheSurveysUseCase>(),
    getIt.get<LogoutUseCase>(),
  );
});

final _surveysStreamProvider = StreamProvider.autoDispose<List<SurveyUiModel>>(
    (ref) => ref.watch(homeViewModelProvider.notifier).surveysStream);

final surveyPageIndexStreamProvider = StreamProvider.autoDispose<int>(
    (ref) => ref.watch(homeViewModelProvider.notifier).surveyPageIndexStream);

final userStreamProvider = StreamProvider.autoDispose<User>(
    (ref) => ref.watch(homeViewModelProvider.notifier).userStream);

final versionInfoProvider = StreamProvider.autoDispose<String>(
    (ref) => ref.watch(homeViewModelProvider.notifier).versionInfoStream);

class HomePage extends ConsumerStatefulWidget {
  @override
  _HomePageState createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends ConsumerState<HomePage> {
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    ref.read(homeViewModelProvider.notifier).getUserProfile();
    ref.read(homeViewModelProvider.notifier).loadSurveys();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<HomeState>(homeViewModelProvider, (_, state) {
      state.maybeWhen(
        loggedOut: () =>
            Navigator.of(context).pushReplacementNamed(Routes.startup),
        orElse: () {},
      );
    });

    final uiModels = ref.watch(_surveysStreamProvider).value;
    return ref.watch(homeViewModelProvider).when(
          init: () => const SizedBox.shrink(),
          loading: () => LoadingIndicator(),
          success: () => _buildHomePage(uiModels ?? []),
          error: (message) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(message ?? context.localization.errorGeneric)));
            });
            return _buildHomePage(uiModels ?? []);
          },
          loggedOut: () => const SizedBox.shrink(),
        );
  }

  Widget _buildHomePage(List<SurveyUiModel> surveys) {
    return Scaffold(
      endDrawer: HomeDrawer(),
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        color: ColorName.blackRussian,
        onRefresh: () => ref
            .read(homeViewModelProvider.notifier)
            .loadSurveys(isRefresh: true),
        child: Stack(
          children: <Widget>[
            SurveyPageViewer(
              surveys: surveys,
              currentPageNotifier: _currentPageNotifier,
            ),
            // Workaround to allow the page to be scrolled vertically to refresh on top
            FractionallySizedBox(
              heightFactor: 0.3,
              child: ListView(),
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
                    _buildCircleIndicator(surveys),
                    SizedBox(height: Dimens.homeFooterHeight)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleIndicator(List<SurveyUiModel> surveys) {
    return Align(
      alignment: Alignment.centerLeft,
      child: CirclePageIndicator(
        size: 8,
        selectedSize: 8,
        dotSpacing: 10,
        dotColor: Colors.white.withOpacity(0.2),
        selectedDotColor: Colors.white,
        itemCount: surveys.length,
        currentPageNotifier: _currentPageNotifier,
      ),
    );
  }

  @override
  void dispose() {
    _currentPageNotifier.dispose();
    super.dispose();
  }
}
