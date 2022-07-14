import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/extensions/date_time_ext.dart';
import 'package:flutter_survey/gen/assets.gen.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          clock.now().toFormattedFullDayMonthYear().toUpperCase(),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(height: 5.0),
        Row(
          children: [
            Expanded(
              child: Text(
                context.localization.homeToday,
                style: Theme.of(context).textTheme.headline5,
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
}
