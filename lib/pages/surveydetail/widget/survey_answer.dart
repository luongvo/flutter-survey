import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_survey/models/question.dart';

class SurveyAnswer extends StatelessWidget {
  final DisplayType displayType;

  SurveyAnswer({required this.displayType});

  @override
  Widget build(BuildContext context) {
    switch (displayType) {
      case DisplayType.dropdown:
        return _buildPicker(context);
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
}
