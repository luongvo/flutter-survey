import 'package:flutter/material.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/resources/dimens.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class HomeFooter extends StatelessWidget {
  final List<int> surveys;
  final ValueNotifier<int> currentPageNotifier;

  HomeFooter({required this.surveys, required this.currentPageNotifier});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCircleIndicator(),
        SizedBox(height: Dimens.defaultMarginPaddingLarge),
        Text(
          // TODO
          'Working from home Check-In',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: Text(
                // TODO
                'We would like to know how you feel about our work from home...',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: Dimens.defaultMarginPadding),
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
          ],
        )
      ],
    );
  }

  Widget _buildCircleIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: CirclePageIndicator(
        size: 8,
        selectedSize: 8,
        dotSpacing: 10,
        dotColor: Colors.white.withOpacity(0.2),
        selectedDotColor: Colors.white,
        itemCount: surveys.length,
        currentPageNotifier: currentPageNotifier,
      ),
    );
  }
}
