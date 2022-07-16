import 'package:flutter/material.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/gen/colors.gen.dart';
import 'package:flutter_survey/pages/uimodel/survey_ui_model.dart';
import 'package:flutter_survey/resources/dimens.dart';

class SurveyStart extends StatelessWidget {
  final SurveyUiModel survey;
  final Function() onNext;

  SurveyStart({
    required this.survey,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Column _buildPage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Dimens.defaultMarginPaddingLarge),
        GestureDetector(
          onTap: () => context.navigateBack(),
          child: SizedBox(
            width: 56,
            height: 56,
            child: Assets.icons.icBack.svg(
              fit: BoxFit.none,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(Dimens.defaultMarginPadding),
            child: _buildContent(context),
          ),
        ),
      ],
    );
  }

  Column _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          survey.title,
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(height: 10.0),
        Text(
          survey.description,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: ColorName.whiteAlpha70),
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
              onPressed: () => onNext(),
            ),
          ],
        ),
      ],
    );
  }
}
