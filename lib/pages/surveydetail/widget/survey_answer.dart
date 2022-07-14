import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/models/question.dart';
import 'package:flutter_survey/pages/common/multi_selection.dart';
import 'package:flutter_survey/pages/common/number_rating.dart';

class SurveyAnswer extends StatelessWidget {
  final DisplayType displayType;

  SurveyAnswer({required this.displayType});

  @override
  Widget build(BuildContext context) {
    switch (displayType) {
      case DisplayType.dropdown:
        return _buildPicker(context);
      case DisplayType.star:
        return _buildRating(
          activeIcon: Assets.icons.icStarActive,
          inactiveIcon: Assets.icons.icStarInactive,
          // TODO bind data https://github.com/luongvo/flutter-survey/issues/19
          itemCount: 5,
          onRate: (rating) {
            // TODO https://github.com/luongvo/flutter-survey/issues/21
          },
        );
      case DisplayType.nps:
        return _buildNumberRating(
          // TODO bind data https://github.com/luongvo/flutter-survey/issues/19
          itemCount: 10,
          onRate: (rating) {
            // TODO https://github.com/luongvo/flutter-survey/issues/21
          },
        );
      case DisplayType.choice:
        return _buildMultiChoice(
          answers: ["Choice 1", "Choice 2", "Choice 3"],
          onItemsChanged: (items) {
            // TODO https://github.com/luongvo/flutter-survey/issues/21
          },
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildPicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
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
            Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),
        selectedTextStyle:
            Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20),
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
        full: activeIcon.image(width: 30, height: 30),
        half: SizedBox.shrink(),
        empty: inactiveIcon.image(width: 30, height: 30),
      ),
      onRatingUpdate: (rating) => onRate(rating.toInt()),
    );
  }

  Widget _buildNumberRating({
    required int itemCount,
    required Function onRate,
  }) {
    return Container(
      height: 120,
      child: NumberRating(
        itemCount: itemCount,
        onRatingUpdate: (value) => onRate(value.toInt()),
        wrapAlignment: WrapAlignment.center,
      ),
    );
  }

  Widget _buildMultiChoice({
    required List<String> answers,
    required Function onItemsChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(80),
      child: MultiSelection(
        // TODO bind id https://github.com/luongvo/flutter-survey/issues/19
        items: answers.map((answer) => SelectionModel("id", answer)).toList(),
        onChanged: (items) => onItemsChanged(items),
      ),
    );
  }
}
