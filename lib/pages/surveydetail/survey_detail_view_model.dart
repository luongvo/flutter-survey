import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/models/survey_detail.dart';
import 'package:flutter_survey/pages/surveydetail/survey_detail_state.dart';
import 'package:flutter_survey/pages/uimodel/survey_ui_model.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/get_survey_detail_use_case.dart';
import 'package:rxdart/subjects.dart';

class SurveyDetailViewModel extends StateNotifier<SurveyDetailState> {
  final GetSurveyDetailUseCase _getSurveyDetailUseCase;

  SurveyDetailViewModel(this._getSurveyDetailUseCase)
      : super(const SurveyDetailState.init());

  final BehaviorSubject<SurveyUiModel> _surveySubject = BehaviorSubject();

  Stream<SurveyUiModel> get surveyStream => _surveySubject.stream;

  Future<void> loadSurveyDetail(SurveyUiModel survey) async {
    // Load initial survey
    state = const SurveyDetailState.loading();
    _surveySubject.add(survey);
    state = const SurveyDetailState.success();

    // Fetch latest survey detail
    state = const SurveyDetailState.loading();
    final result = await _getSurveyDetailUseCase.call(GetSurveyDetailInput(
      surveyId: survey.id,
    ));
    if (result is Success<SurveyDetail>) {
      final surveyDetail = result.value;
      _surveySubject.add(SurveyUiModel.fromSurveyDetail(survey, surveyDetail));
      state = const SurveyDetailState.success();
    } else {
      _handleError(result as Failed);
    }
  }

  _handleError(Failed result) {
    state = SurveyDetailState.error(result.getErrorMessage());
  }

  @override
  void dispose() async {
    await _surveySubject.close();
    super.dispose();
  }
}
