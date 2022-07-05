import 'package:flutter_survey/pages/uimodel/survey_ui_model.dart';

class SurveyUiModelMocks {
  static SurveyUiModel mock() => SurveyUiModel(
        id: 'id',
        title: 'title',
        description: 'description',
        coverImageUrl: 'coverImageUrl',
        questions: [],
      );
}
