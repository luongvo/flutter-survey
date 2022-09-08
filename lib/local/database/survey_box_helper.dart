import 'package:flutter_survey/models/survey.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

abstract class SurveyBoxHelper {
  List<Survey> get surveys;

  void saveSurveys(List<Survey> surveys);

  void clear();
}

@Singleton(as: SurveyBoxHelper)
class SurveyBoxHelperImpl extends SurveyBoxHelper {
  Box _surveyBox;

  final String _surveyKey = 'surveys';

  SurveyBoxHelperImpl(@Named('surveyBox') this._surveyBox);

  @override
  List<Survey> get surveys =>
      List<Survey>.from(_surveyBox.get(_surveyKey, defaultValue: []));

  @override
  void saveSurveys(List<Survey> surveys) async {
    final currentSurveys = this.surveys;
    currentSurveys.addAll(surveys);
    await _surveyBox.put(_surveyKey, currentSurveys);
  }

  @override
  void clear() async {
    await _surveyBox.delete(_surveyKey);
  }
}
