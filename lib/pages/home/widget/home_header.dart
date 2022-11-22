import 'package:cached_network_image/cached_network_image.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/extensions/date_time_ext.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/pages/home/home_page.dart';
import 'package:flutter_survey/resources/dimens.dart';

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
            GestureDetector(
              key: HomePageKey.ivAvatar,
              onTap: () => Scaffold.of(context).openEndDrawer(),
              child: Consumer(
                builder: (BuildContext _, WidgetRef widgetRef, __) {
                  final user = widgetRef.watch(userStreamProvider).value;
                  if (user == null) return SizedBox.shrink();
                  return CachedNetworkImage(
                    imageUrl: user.avatarUrl,
                    imageBuilder: (_, imageProvider) => Container(
                      width: Dimens.homeAvatarSize,
                      height: Dimens.homeAvatarSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    errorWidget: (_, url, error) =>
                        Assets.images.bgHomeAvatarSample.image(),
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
