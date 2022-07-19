import 'package:flutter/material.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/gen/colors.gen.dart';
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          // TODO bind user name
                          "Mai",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Container(
                        width: Dimens.homeAvatarSize,
                        height: Dimens.homeAvatarSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: Assets.images.bgHomeAvatarSample,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                  Text(
                    context.localization.logout,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 20.0,
                        ),
                  ),
                  Expanded(child: SizedBox.shrink()),
                  Text(
                    // TODO bind app version
                    "v1.0.0",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 11.0,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
