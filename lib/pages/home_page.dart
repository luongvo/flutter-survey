import 'package:flutter/material.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/pages/widgets/dimmed_background.dart';
import 'package:flutter_survey/resources/dimens.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Assets.images.bgHomeSample,
                fit: BoxFit.cover,
              ),
            ),
          ),
          _buildDimmedBackground(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(Dimens.defaultMarginPadding),
              child: _buildHomeDetail(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeDetail(BuildContext context) {
    return Column(
      children: [
        _buildHomeHeader(context),
        Expanded(
          child: SizedBox.shrink(),
        ),
        _buildHomeFooter(context),
      ],
    );
  }

  Widget _buildHomeHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          // TODO
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
                // TODO
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

  Widget _buildHomeFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              child: Container(
                height: 8,
                width: 8,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10.0),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              child: Container(
                height: 8,
                width: 8,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            SizedBox(width: 10.0),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              child: Container(
                height: 8,
                width: 8,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ],
        ),
        SizedBox(height: Dimens.defaultMarginPaddingLarge),
        Text(
          // TODO
          'Working from home Check-In',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                // TODO
                'We would like to know how you feel about our work from home...',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: Dimens.defaultMarginPadding),
              child: ClipOval(
                child: Material(
                  color: Colors.white,
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Assets.icons.icArrowRight.svg(
                      fit: BoxFit.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildDimmedBackground() => DimmedBackground(
        colors: [
          Colors.black.withOpacity(0.2),
          Colors.black.withOpacity(0.7),
        ],
        stops: [0.0, 1.0],
      );
}
