import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_survey/gen/colors.gen.dart';
import 'package:flutter_survey/gen/fonts.gen.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        fontFamily: FontFamily.neuzeit,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          button: TextStyle(
            color: ColorName.blackRussian,
            fontWeight: FontWeight.w800,
            fontSize: 17,
          ),
        ),
      );
}
