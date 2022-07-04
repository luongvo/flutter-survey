import 'package:flutter/material.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/pages/uimodel/survey_ui_model.dart';
import 'package:flutter_survey/pages/widgets/dimmed_background.dart';
import 'package:flutter_survey/resources/dimens.dart';

class StartSurvey extends StatelessWidget {
  final SurveyUiModel survey;

  StartSurvey({required this.survey});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.network(survey.coverImageUrl).image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        DimmedBackground(
          colors: [
            Colors.black.withOpacity(0.2),
            Colors.black.withOpacity(0.7),
          ],
          stops: const [0.0, 1.0],
        ),
        Padding(
          padding: const EdgeInsets.all(Dimens.defaultMarginPadding),
          child: _buildContent(context),
        ),
      ],
    );
  }

  Column _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: Dimens.defaultMarginPaddingLarge),
        Text(
          "Working from home Check-In",
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(height: 10.0),
        Text(
          "We would like to know how you feel about our work from home (WFH) experience.",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Expanded(child: SizedBox.shrink()),
        Row(
          children: [
            Expanded(child: SizedBox.shrink()),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.black),
                overlayColor: MaterialStateProperty.all(Colors.black12),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    vertical: Dimens.inputVerticalPadding,
                  ),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Dimens.inputBorderRadius)),
                ),
                textStyle: MaterialStateProperty.all(
                  Theme.of(context).textTheme.button,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.defaultMarginPadding),
                child: Text(context.localization.surveyStart),
              ),
              onPressed: () {
                // TODO start
              },
            ),
          ],
        ),
      ],
    );
  }
}
