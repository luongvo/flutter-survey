import 'package:flutter/material.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/gen/colors.gen.dart';
import 'package:flutter_survey/models/question.dart';
import 'package:flutter_survey/pages/surveydetail/page/survey_answer.dart';
import 'package:flutter_survey/resources/dimens.dart';

class SurveyQuestion extends StatelessWidget {
  final Question question;
  final int index;
  final int total;
  final Function() onNext;
  final Function() onSubmit;

  SurveyQuestion({
    required this.question,
    required this.index,
    required this.total,
    required this.onNext,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Column _buildPage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: SizedBox.shrink()),
            Padding(
              padding: const EdgeInsets.only(left: Dimens.defaultMarginPadding),
              child: GestureDetector(
                onTap: () => context.navigateBack(),
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
          "$index/$total",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: ColorName.whiteAlpha70),
        ),
        const SizedBox(height: 10.0),
        Text(
          question.text,
          style: Theme.of(context).textTheme.headline5,
        ),
        Expanded(child: SizedBox.shrink()),
        Align(
          alignment: Alignment.center,
          child: SurveyAnswer(question: question),
        ),
        Expanded(child: SizedBox.shrink()),
        Row(
          children: [
            Expanded(child: SizedBox.shrink()),
            _buildActionButton(context),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return index < total
        ? Padding(
            padding: const EdgeInsets.only(left: Dimens.defaultMarginPadding),
            child: GestureDetector(
              onTap: () => onNext(),
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
          )
        : TextButton(
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
              child: Text(context.localization.surveySubmit),
            ),
            onPressed: () => onSubmit(),
          );
  }
}
