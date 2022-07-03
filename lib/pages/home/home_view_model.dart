import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/models/survey.dart';
import 'package:flutter_survey/pages/home/home_state.dart';
import 'package:flutter_survey/pages/uimodel/survey_ui_model.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/get_surveys_use_case.dart';
import 'package:rxdart/subjects.dart';

const _pageSize = 10;

class HomeViewModel extends StateNotifier<HomeState> {
  final GetSurveysUseCase _getSurveysUseCase;

  HomeViewModel(this._getSurveysUseCase) : super(const HomeState.init()) {
    loadSurveys();
  }

  int _page = 1;

  final BehaviorSubject<List<SurveyUiModel>> _surveysSubject =
      BehaviorSubject();

  Stream<List<SurveyUiModel>> get surveyUiModelsStream =>
      _surveysSubject.stream;

  Future<void> loadSurveys({bool isRefresh = false}) async {
    _page = 1;

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
      // _handleError(result as Failed);
    }
  }
}
