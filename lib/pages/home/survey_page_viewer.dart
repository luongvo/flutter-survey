import 'package:flutter/material.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/pages/widgets/dimmed_background.dart';

class SurveyPageViewer extends StatelessWidget {
  final List<int> surveys;
  final ValueNotifier<int> currentPageNotifier;
  final _pageController = PageController();

  SurveyPageViewer({required this.surveys, required this.currentPageNotifier});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: surveys.length,
      controller: _pageController,
      itemBuilder: (BuildContext context, int index) {
        return _buildSurveyPageView(context);
      },
      onPageChanged: (int index) {
        currentPageNotifier.value = index;
      },
    );
  }

  Widget _buildSurveyPageView(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.bgHomeSample,
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
      ],
    );
  }
}
