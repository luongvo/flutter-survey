import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/api/request/submit_survey_request.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/models/answer.dart';
import 'package:flutter_survey/models/question.dart';
import 'package:flutter_survey/pages/surveydetail/survey_detail_page.dart';
import 'package:flutter_survey/pages/surveydetail/widget/multi_selection.dart';
import 'package:flutter_survey/pages/surveydetail/widget/number_rating.dart';
import 'package:flutter_survey/pages/surveydetail/widget/smiley_rating.dart';
import 'package:flutter_survey/pages/widgets/decoration/custom_input_decoration.dart';

class SurveyAnswer extends ConsumerStatefulWidget {
  final Question question;

  SurveyAnswer({required this.question}) : super();

  @override
  _SurveyAnswerState createState() {
    return new _SurveyAnswerState();
  }
}

class _SurveyAnswerState extends ConsumerState<SurveyAnswer> {
  @override
  Widget build(BuildContext context) {
    switch (widget.question.displayType) {
      case DisplayType.dropdown:
        return _buildPicker(
          context: context,
          answers: widget.question.answers,
          onSelect: (answer) => saveDropdownAnswers(answer),
        );
      case DisplayType.star:
        return _buildRating(
          activeIcon: Assets.icons.icStarActive,
          inactiveIcon: Assets.icons.icStarInactive,
          itemCount: widget.question.answers.length,
          onRate: (rating) => _saveRatingAnswers(rating),
        );
      case DisplayType.heart:
        return _buildRating(
          activeIcon: Assets.icons.icHeartActive,
          inactiveIcon: Assets.icons.icHeartInactive,
          itemCount: widget.question.answers.length,
          onRate: (rating) => _saveRatingAnswers(rating),
        );
      case DisplayType.smiley:
        return _buildSmileyRating(
          itemCount: widget.question.answers.length,
          onRate: (rating) => _saveRatingAnswers(rating),
        );
      case DisplayType.nps:
        return _buildNumberRating(
          itemCount: widget.question.answers.length,
          onRate: (rating) => _saveRatingAnswers(rating),
        );
      case DisplayType.choice:
        return _buildMultiChoice(
          answers: widget.question.answers,
          onItemsChanged: (items) => _saveMultiSelectionAnswers(
            items.map((e) => SubmitAnswer(id: e.id, answer: e.label)).toList(),
          ),
        );
      case DisplayType.textfield:
        return _buildTextFields(
          context: context,
          answers: widget.question.answers,
          onItemChanged: (answerId, text) =>
              _saveTextFieldAnswers(answerId, text),
        );
      case DisplayType.textarea:
        return _buildTextArea(
          context: context,
          onItemChanged: (text) => _saveTextAreaAnswers(text),
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildPicker({
    required BuildContext context,
    required List<Answer> answers,
    required Function(Answer) onSelect,
  }) {
    onSelect(answers[0]); // default
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80.0),
      child: Picker(
        adapter: PickerDataAdapter<String>(
          pickerdata: answers.map((e) => e.text).toList(),
        ),
        textAlign: TextAlign.center,
        textStyle:
            Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20.0),
        selectedTextStyle:
            Theme.of(context).textTheme.headline4?.copyWith(fontSize: 20.0),
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
        onSelect: (_, __, selected) {
          onSelect(answers[selected.first]);
        },
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
    required Function(List<SelectionModel>) onItemsChanged,
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
          .map((answer) => Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: TextFormField(
                  autofocus: true,
                  onChanged: (text) => onItemChanged(answer.id, text),
                  decoration: CustomInputDecoration(
                    context: context,
                    hint: answer.text,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context).textTheme.bodyText1,
                  textInputAction: (answers.last.id != answer.id)
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

  void saveDropdownAnswers(Answer answer) {
    ref
        .read(surveyDetailViewModelProvider.notifier)
        .saveDropdownAnswers(widget.question.id, answer);
  }

  void _saveRatingAnswers(int rating) {
    ref
        .read(surveyDetailViewModelProvider.notifier)
        .saveRatingAnswers(widget.question.id, rating);
  }

  void _saveMultiSelectionAnswers(List<SubmitAnswer> answers) {
    ref
        .read(surveyDetailViewModelProvider.notifier)
        .saveMultiSelectionAnswers(widget.question.id, answers);
  }

  void _saveTextAreaAnswers(String text) {
    ref
        .read(surveyDetailViewModelProvider.notifier)
        .saveTextAreaAnswers(widget.question.id, text);
  }

  void _saveTextFieldAnswers(String answerId, String text) {
    ref
        .read(surveyDetailViewModelProvider.notifier)
        .saveTextFieldAnswers(widget.question.id, answerId, text);
  }
}
