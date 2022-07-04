import 'package:flutter/material.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/pages/surveydetail/widget/start_survey.dart';
import 'package:flutter_survey/pages/uimodel/survey_ui_model.dart';

class SurveyDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final survey = context.arguments as SurveyUiModel;
    return _buildSurveyPage(survey);
  }

  Widget _buildSurveyPage(SurveyUiModel survey) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StartSurvey(
        survey: survey,
      ),
    );
  }
}
