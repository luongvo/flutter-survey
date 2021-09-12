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
        // TODO
        Text('MONDAY, JUNE 15'),
        Text('Today'),
      ],
    );
  }

  Widget _buildHomeFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          // TODO
          "●●●",
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          // TODO
          'Working from home Check-In',
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
