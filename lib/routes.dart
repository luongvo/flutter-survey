import 'package:flutter/material.dart';
import 'package:flutter_survey/pages/home/home_page.dart';
import 'package:flutter_survey/pages/startup_page.dart';

class Routes {
  Routes._();

  static const String STARTUP_PAGE = "/";
  static const String HOME_PAGE = "/home";

  static final routes = <String, WidgetBuilder>{
    STARTUP_PAGE: (BuildContext context) => StartupPage(),
    HOME_PAGE: (BuildContext context) => HomePage(),
  };
}
