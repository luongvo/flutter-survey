import 'package:flutter/material.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/pages/uimodel/survey_ui_model.dart';
import 'package:flutter_survey/resources/dimens.dart';
import 'package:flutter_survey/routes.dart';

class HomeFooter extends StatelessWidget {
  final SurveyUiModel survey;

  HomeFooter({required this.survey});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: Dimens.defaultMarginPaddingLarge),
        Text(
          survey.title,
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: Text(
                survey.description,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: Dimens.defaultMarginPadding),
              child: ClipOval(
                child: Material(
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: () => _navigateToSurvey(context),
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: Assets.icons.icArrowRight.svg(
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  void _navigateToSurvey(BuildContext context) {
    Navigator.pushNamed(context, Routes.SURVEY, arguments: survey);
  }
}
