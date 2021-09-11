import 'package:flutter/material.dart';
import 'package:flutter_survey/pages/home_page.dart';

class Routes {
  Routes._();

  static const String HOME_PAGE = "/home";

  static final routes = <String, WidgetBuilder>{
    HOME_PAGE: (BuildContext context) => HomePage(),
  };
}
