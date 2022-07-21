import 'package:flutter/material.dart';
import 'package:flutter_survey/gen/colors.gen.dart';
import 'package:flutter_survey/resources/dimens.dart';

class CustomInputDecoration extends InputDecoration {
  final BuildContext context;
  final String hint;

  CustomInputDecoration({required this.context, required this.hint})
      : super(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(
              Dimens.inputBorderRadius,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: Dimens.inputHorizontalPadding,
            vertical: Dimens.inputVerticalPadding,
          ),
          fillColor: ColorName.whiteAlpha18,
          filled: true,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: ColorName.whiteAlpha18),
          hintText: hint,
        );
}
