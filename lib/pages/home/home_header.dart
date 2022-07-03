import 'package:flutter/material.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:intl/intl.dart';

const String PATTERN_FULL_DATE_MONTH_DAY = 'EEEE, MMMM dd';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          _composeCurrentDate(),
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

  String _composeCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat(PATTERN_FULL_DATE_MONTH_DAY);
    return formatter.format(now).toUpperCase();
  }
}
