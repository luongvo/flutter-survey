import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/pages/surveydetail/survey_detail_state.dart';
import 'package:flutter_survey/pages/uimodel/survey_ui_model.dart';
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
  }

  @override
  void dispose() async {
    await _surveySubject.close();
    super.dispose();
  }
}
