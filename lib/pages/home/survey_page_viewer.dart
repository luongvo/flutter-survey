import 'package:flutter/material.dart';
import 'package:flutter_survey/pages/home/home_footer.dart';
import 'package:flutter_survey/pages/uimodel/survey_ui_model.dart';
import 'package:flutter_survey/pages/widgets/dimmed_image_background.dart';
import 'package:flutter_survey/resources/dimens.dart';

class SurveyPageViewer extends StatelessWidget {
  final List<SurveyUiModel> surveys;
  final ValueNotifier<int> currentPageNotifier;
  final _pageController = PageController();

  SurveyPageViewer({required this.surveys, required this.currentPageNotifier});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: surveys.length,
      controller: _pageController,
      itemBuilder: (BuildContext context, int index) {
        return _buildSurveyPageView(context, surveys[index]);
      },
      onPageChanged: (int index) {
        currentPageNotifier.value = index;
      },
    );
  }

  Widget _buildSurveyPageView(BuildContext context, SurveyUiModel survey) {
    return Stack(
      children: [
        DimmedImageBackground(
          image: Image.network(survey.coverImageUrl).image,
        ),
        Padding(
          padding: const EdgeInsets.all(Dimens.defaultMarginPadding),
          child: Column(
            children: [
              Expanded(
                child: const SizedBox.shrink(),
              ),
              HomeFooter(
                survey: survey,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
