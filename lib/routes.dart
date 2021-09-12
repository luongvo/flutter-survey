import 'package:flutter/material.dart';
import 'package:flutter_survey/pages/home_page.dart';
import 'package:flutter_survey/pages/login_page.dart';

class Routes {
  Routes._();

  static const String LOGIN_PAGE = "/";
  static const String HOME_PAGE = "/home";

  static final routes = <String, WidgetBuilder>{
    LOGIN_PAGE: (BuildContext context) => LoginPage(),
    HOME_PAGE: (BuildContext context) => HomePage(),
  };
}
