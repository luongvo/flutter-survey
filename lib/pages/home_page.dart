import 'package:flutter/material.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/pages/widgets/dimmed_background.dart';
import 'package:flutter_survey/resources/dimens.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  // TODO
  final _surveys = [1, 2, 3];
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          _buildSurveyPageViewer(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(Dimens.defaultMarginPadding),
              child: _buildSurveyDetail(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurveyPageViewer() {
    return PageView.builder(
      itemCount: _surveys.length,
      controller: _pageController,
      itemBuilder: (BuildContext context, int index) {
        return _buildSurveyPageView(context);
      },
      onPageChanged: (int index) {
        _currentPageNotifier.value = index;
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
        _buildDimmedBackground(),
      ],
    );
  }

  Widget _buildSurveyDetail(BuildContext context) {
    return Column(
      children: [
        _buildHomeHeader(context),
        Expanded(
          child: SizedBox.shrink(),
        ),
        _buildHomeFooter(context),
      ],
    );
  }

  Widget _buildHomeHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          // TODO
          'MONDAY, JUNE 15',
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontSize: 13,
              ),
        ),
        SizedBox(height: 5.0),
        Row(
          children: [
            Expanded(
              child: Text(
                // TODO
                'Today',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: 34,
                    ),
              ),
            ),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: Assets.images.bgHomeAvatarSample,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildHomeFooter(BuildContext context) {
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
        itemCount: _surveys.length,
        currentPageNotifier: _currentPageNotifier,
      ),
    );
  }

  Widget _buildDimmedBackground() => DimmedBackground(
        colors: [
          Colors.black.withOpacity(0.2),
          Colors.black.withOpacity(0.7),
        ],
        stops: [0.0, 1.0],
      );
}
