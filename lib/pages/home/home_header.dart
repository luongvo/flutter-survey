import 'package:flutter/material.dart';
import 'package:flutter_survey/gen/assets.gen.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          // TODO data binding https://github.com/luongvo/flutter-survey/issues/14
          'MONDAY, JUNE 15',
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontSize: 13,
              ),
        ),
        SizedBox(height: 5.0),
        Row(
          children: [
            Expanded(
              child: Text(
                // TODO data binding https://github.com/luongvo/flutter-survey/issues/14
                'Today',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: 34,
                    ),
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
