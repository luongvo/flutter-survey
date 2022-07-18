import 'package:flutter/material.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/gen/colors.gen.dart';

const _DELAY_TIME = 3;

class CompletionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: _DELAY_TIME), () async {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });

    return Container(
      color: ColorName.blackRussian,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: SizedBox.shrink()),
          Assets.images.bgCompletion.image(),
          Text(
            context.localization.completionThanks,
            style:
                Theme.of(context).textTheme.headline5!.copyWith(fontSize: 28.0),
            textAlign: TextAlign.center,
          ),
          Expanded(child: SizedBox.shrink()),
        ],
      ),
    );
  }
}
