import 'package:flutter/material.dart';
import 'package:flutter_survey/pages/completion/completion_page.dart';
import 'package:flutter_survey/pages/home/home_page.dart';
import 'package:flutter_survey/pages/resetpassword/reset_password_page.dart';
import 'package:flutter_survey/pages/startup_page.dart';
import 'package:flutter_survey/pages/surveydetail/survey_detail_page.dart';

class Routes {
  Routes._();

  static const String startup = "/";
  static const String resetPassword = "/reset-password";
  static const String home = "/home";
  static const String survey = "/survey";
  static const String completion = "/completion";

  static final routes = <String, WidgetBuilder>{
    startup: (BuildContext context) => StartupPage(),
    resetPassword: (BuildContext context) => ResetPasswordPage(),
    home: (BuildContext context) => HomePage(),
    survey: (BuildContext context) => SurveyDetailPage(),
    completion: (BuildContext context) => CompletionPage(),
  };
}
