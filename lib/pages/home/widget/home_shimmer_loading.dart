import 'package:cached_network_image/cached_network_image.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/extensions/date_time_ext.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/gen/colors.gen.dart';
import 'package:flutter_survey/resources/dimens.dart';

class HomeShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.blackRussian,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.defaultMarginPadding),
          child: Column(
            children: [
              _buildShimmerHeader(context),
              Expanded(child: const SizedBox.shrink()),
              _buildShimmerFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerHeader(BuildContext context) {
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
            CachedNetworkImage(
              imageUrl: "",
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
        )
      ],
    );
  }

  Widget _buildShimmerFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: Dimens.defaultMarginPaddingLarge),
        Text(
          "title",
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: 10.0),
        Text(
          "description",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: ColorName.whiteAlpha70),
        ),
        const SizedBox(height: 18.0),
      ],
    );
  }
}
