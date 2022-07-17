import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/models/answer.dart';
import 'package:flutter_survey/models/question.dart';
import 'package:flutter_survey/pages/common/multi_selection.dart';
import 'package:flutter_survey/pages/common/number_rating.dart';
import 'package:flutter_survey/pages/common/smiley_rating.dart';
import 'package:flutter_survey/pages/widgets/decoration/custom_input_decoration.dart';

class SurveyAnswer extends ConsumerWidget {
  final Question question;

  SurveyAnswer({required this.question});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (question.displayType) {
      case DisplayType.dropdown:
        return _buildPicker(context);
      case DisplayType.star:
        return _buildRating(
          activeIcon: Assets.icons.icStarActive,
          inactiveIcon: Assets.icons.icStarInactive,
          itemCount: question.answers.length,
          onRate: (rating) {
            // TODO https://github.com/luongvo/flutter-survey/issues/21
          },
        );
      case DisplayType.heart:
        return _buildRating(
          activeIcon: Assets.icons.icHeartActive,
          inactiveIcon: Assets.icons.icHeartInactive,
          itemCount: question.answers.length,
          onRate: (rating) {
            // TODO https://github.com/luongvo/flutter-survey/issues/21
          },
        );
      case DisplayType.smiley:
        return _buildSmileyRating(
          ref: ref,
          itemCount: question.answers.length,
          onRate: (rating) {
            // TODO https://github.com/luongvo/flutter-survey/issues/21
          },
        );
      case DisplayType.nps:
        return _buildNumberRating(
          itemCount: question.answers.length,
          onRate: (rating) {
            // TODO https://github.com/luongvo/flutter-survey/issues/21
          },
        );
      case DisplayType.choice:
        return _buildMultiChoice(
          answers: question.answers,
          onItemsChanged: (items) {
            // TODO https://github.com/luongvo/flutter-survey/issues/21
          },
        );
      case DisplayType.textfield:
        return _buildTextFields(
            context: context,
            answers: question.answers,
            onItemChanged: (answerId, text) {
              // TODO https://github.com/luongvo/flutter-survey/issues/21
            });
      case DisplayType.textarea:
        return _buildTextArea(
          context: context,
          onItemChanged: (text) {
            // TODO https://github.com/luongvo/flutter-survey/issues/21
          },
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildPicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80.0),
      child: Picker(
        // TODO bind data https://github.com/luongvo/flutter-survey/issues/19
        adapter: PickerDataAdapter<String>(
          pickerdata: [
            "Very fulfilled",
            "Somewhat fullfilled",
            "Somewhat unfulfilled"
          ],
        ),
        textAlign: TextAlign.center,
        textStyle:
            Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20.0),
        selectedTextStyle:
            Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20.0),
        selectionOverlay: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.white, width: 0.5),
              bottom: BorderSide(color: Colors.white, width: 0.5),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        headerColor: Colors.transparent,
        containerColor: Colors.transparent,
        itemExtent: 50,
        hideHeader: true,
      ).makePicker(),
    );
  }

  Widget _buildRating({
    required AssetGenImage activeIcon,
    required AssetGenImage inactiveIcon,
    required int itemCount,
    required Function onRate,
  }) {
    return RatingBar(
      itemCount: itemCount,
      ratingWidget: RatingWidget(
        full: activeIcon.image(width: 30.0, height: 30.0),
        half: SizedBox.shrink(),
        empty: inactiveIcon.image(width: 30.0, height: 30.0),
      ),
      onRatingUpdate: (rating) => onRate(rating.toInt()),
    );
  }

  Widget _buildNumberRating({
    required int itemCount,
    required Function onRate,
  }) {
    return Container(
      height: 120.0,
      child: NumberRating(
        itemCount: itemCount,
        onRatingUpdate: (value) => onRate(value.toInt()),
        wrapAlignment: WrapAlignment.center,
      ),
    );
  }

  Widget _buildSmileyRating({
    required WidgetRef ref,
    required int itemCount,
    required Function onRate,
  }) {
    // select default value
    onRate(ref.read(selectedEmojiIndexProvider.notifier).state + 1);

    return SmileyRating(
      itemCount: itemCount,
      onRate: (rating) => onRate(rating.toInt()),
    );
  }

  Widget _buildMultiChoice({
    required List<Answer> answers,
    required Function onItemsChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(80.0),
      child: MultiSelection(
        items: answers
            .map((answer) => SelectionModel(answer.id, answer.text))
            .toList(),
        onChanged: (items) => onItemsChanged(items),
      ),
    );
  }

  Widget _buildTextFields({
    required BuildContext context,
    required List<Answer> answers,
    required Function onItemChanged,
  }) {
    return Column(
      children: answers
          .map((value) => Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: TextFormField(
                  autofocus: true,
                  onChanged: (text) => onItemChanged(value.id, text),
                  decoration: CustomInputDecoration(
                    context: context,
                    hint: value.text,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context).textTheme.bodyText1,
                  textInputAction: (answers.last.id != value.id)
                      ? TextInputAction.next
                      : TextInputAction.done,
                ),
              ))
          .toList(),
    );
  }

  Widget _buildTextArea({
    required BuildContext context,
    required Function onItemChanged,
  }) {
    return TextFormField(
      autofocus: true,
      onChanged: (text) => onItemChanged(text),
      decoration: CustomInputDecoration(
        context: context,
        hint: context.localization.surveyAnswerTextAreaHint,
      ),
      style: Theme.of(context).textTheme.bodyText1,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.done,
      maxLines: 5,
    );
  }
}
