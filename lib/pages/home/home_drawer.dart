import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/gen/colors.gen.dart';
import 'package:flutter_survey/pages/home/home_page.dart';
import 'package:flutter_survey/resources/dimens.dart';

const double _drawerWidthFactor = 240.0 / 376.0;

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: ColorName.nero90,
      ),
      child: FractionallySizedBox(
        widthFactor: _drawerWidthFactor,
        child: Drawer(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.only(
                top: 50.0,
                left: Dimens.defaultMarginPadding,
                right: Dimens.defaultMarginPadding,
                bottom: Dimens.defaultMarginPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bindUserInfo(context),
                  SizedBox(
                    height: Dimens.defaultMarginPadding,
                  ),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  _bindMenu(context),
                  Expanded(child: SizedBox.shrink()),
                  _buildVersionInfo(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bindUserInfo(BuildContext context) {
    return Consumer(
      builder: (BuildContext _, WidgetRef widgetRef, __) {
        final user = widgetRef.watch(userStreamProvider).value;
        return Row(
          children: [
            Expanded(
              child: Text(
                user?.name ?? "",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            CachedNetworkImage(
              imageUrl: user?.avatarUrl ?? "",
              imageBuilder: (_, imageProvider) => Container(
                width: Dimens.homeAvatarSize,
                height: Dimens.homeAvatarSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              errorWidget: (_, url, error) =>
                  Assets.images.bgHomeAvatarSample.image(),
            ),
          ],
        );
      },
    );
  }

  Widget _bindMenu(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO https://github.com/luongvo/flutter-survey/issues/29
      },
      child: Text(
        context.localization.logout,
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
              color: Colors.white.withOpacity(0.5),
              fontSize: 20.0,
            ),
      ),
    );
  }

  Widget _buildVersionInfo(BuildContext context) {
    return Consumer(
      builder: (BuildContext _, WidgetRef widgetRef, __) {
        final versionInfo = widgetRef.watch(versionInfoProvider).value;
        return Text(
          versionInfo ?? '',
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: Colors.white.withOpacity(0.5),
                fontSize: 11.0,
              ),
        );
      },
    );
  }
}
