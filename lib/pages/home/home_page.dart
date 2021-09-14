import 'package:flutter/material.dart';
import 'package:flutter_survey/pages/home/home_footer.dart';
import 'package:flutter_survey/pages/home/home_header.dart';
import 'package:flutter_survey/pages/home/survey_page_viewer.dart';
import 'package:flutter_survey/resources/dimens.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  // TODO
  final _surveys = [1, 2, 3];
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          SurveyPageViewer(
            surveys: _surveys,
            currentPageNotifier: _currentPageNotifier,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(Dimens.defaultMarginPadding),
              child: Column(
                children: [
                  HomeHeader(),
                  Expanded(
                    child: SizedBox.shrink(),
                  ),
                  HomeFooter(
                    surveys: _surveys,
                    currentPageNotifier: _currentPageNotifier,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
