import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/models/survey.dart';
import 'package:flutter_survey/models/user.dart';
import 'package:flutter_survey/pages/home/home_state.dart';
import 'package:flutter_survey/pages/uimodel/survey_ui_model.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/get_surveys_use_case.dart';
import 'package:flutter_survey/usecase/get_user_profile_use_case.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rxdart/subjects.dart';

const _pageSize = 10;

class HomeViewModel extends StateNotifier<HomeState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final GetSurveysUseCase _getSurveysUseCase;

  HomeViewModel(
    this._getUserProfileUseCase,
    this._getSurveysUseCase,
  ) : super(const HomeState.init());

  int _page = 1;

  final BehaviorSubject<User> _userSubject = BehaviorSubject();

  Stream<User> get userStream => _userSubject.stream;

  final BehaviorSubject<List<SurveyUiModel>> _surveysSubject =
      BehaviorSubject();

  Stream<List<SurveyUiModel>> get surveysStream => _surveysSubject.stream;

  Stream<String> get versionInfoStream => _fetchAppVersion().asStream();

  Future<void> loadSurveys({bool isRefresh = false}) async {
    _page = 1;
    if (!isRefresh) {
      state = const HomeState.loading();
    }

    final result = await _getSurveysUseCase.call(GetSurveysInput(
      pageNumber: _page,
      pageSize: _pageSize,
    ));
    if (result is Success<List<Survey>>) {
      final uiModels =
          result.value.map((job) => SurveyUiModel.fromSurvey(job)).toList();
      _surveysSubject.add(uiModels);
      state = const HomeState.success();
    } else {
      _handleError(result as Failed);
    }
  }

  Future<void> getUserProfile() async {
    final result = await _getUserProfileUseCase.call();
    if (result is Success<User>) {
      _userSubject.add(result.value);
    } else {
      _handleError(result as Failed);
    }
  }

  _handleError(Failed result) {
    state = HomeState.error(result.getErrorMessage());
  }

  @override
  void dispose() async {
    await _surveysSubject.close();
    super.dispose();
  }

  Future<String> _fetchAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      // non-translated, example: v1.1.1 (11)
      return "v${packageInfo.version} (${packageInfo.buildNumber})";
    } catch (exception) {
      return '';
    }
  }
}
