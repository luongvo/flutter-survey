import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/pages/home/home_state.dart';
import 'package:flutter_survey/usecase/get_surveys_use_case.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  final GetSurveysUseCase _getSurveysUseCase;

  HomeViewModel(this._getSurveysUseCase) : super(const HomeState.init()) {
    init();
  }

  Future<void> init() async {
    // TODO fetch survey list https://github.com/luongvo/flutter-survey/issues/14
    await _getSurveysUseCase.call(GetSurveysInput(
      pageNumber: 1,
      pageSize: 2,
    ));
  }
}
