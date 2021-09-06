import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_survey/resouces/app_colors.dart';
import 'package:flutter_survey/resouces/fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        fontFamily: Fonts.neuzeit,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
          button: TextStyle(
            color: AppColors.blackRussian,
            fontWeight: FontWeight.w800,
            fontSize: 17,
          ),
        ),
      );
}
