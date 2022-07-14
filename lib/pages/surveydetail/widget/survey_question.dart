import 'package:flutter/material.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/gen/colors.gen.dart';
import 'package:flutter_survey/pages/uimodel/survey_ui_model.dart';
import 'package:flutter_survey/pages/widgets/dimmed_background.dart';
import 'package:flutter_survey/resources/dimens.dart';

class SurveyQuestion extends StatelessWidget {
  final SurveyUiModel survey;

  SurveyQuestion({required this.survey});

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
        _buildPage(context),
      ],
    );
  }

  Column _buildPage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Dimens.defaultMarginPaddingLarge),
        Row(
          children: [
            Expanded(child: SizedBox.shrink()),
            Padding(
              padding: const EdgeInsets.only(left: Dimens.defaultMarginPadding),
              child: GestureDetector(
                onTap: () {
                  // TODO https://github.com/luongvo/flutter-survey/issues/19
                },
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Assets.icons.icClose.svg(
                    fit: BoxFit.none,
                  ),
                ),
              ),
            ),
          ],
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
          // TODO bind index https://github.com/luongvo/flutter-survey/issues/19
          "1/5",
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: ColorName.whiteAlpha70),
        ),
        const SizedBox(height: 10.0),
        Text(
          // TODO bind data https://github.com/luongvo/flutter-survey/issues/19
          "How fulfilled did you feel during this WFH period?",
          style: Theme.of(context).textTheme.headline5,
        ),
        Expanded(child: SizedBox.shrink()),
        Row(
          children: [
            Expanded(child: SizedBox.shrink()),
            Padding(
              padding: const EdgeInsets.only(left: Dimens.defaultMarginPadding),
              child: GestureDetector(
                onTap: () {
                  // TODO https://github.com/luongvo/flutter-survey/issues/19
                },
                child: ClipOval(
                  child: Material(
                    color: Colors.white,
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
        ),
      ],
    );
  }
}
