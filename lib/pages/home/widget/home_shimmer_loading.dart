import 'package:flutter/material.dart';
import 'package:flutter_survey/gen/colors.gen.dart';
import 'package:flutter_survey/resources/dimens.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.blackRussian,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.defaultMarginPadding),
          child: Shimmer.fromColors(
            baseColor: Colors.white54,
            highlightColor: Colors.white70,
            child: _buildShimmerContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFakeTextContent(screenWidth / 3),
        const SizedBox(height: 5.0),
        Row(
          children: [
            _buildFakeTextContent(screenWidth / 4),
            const Expanded(child: const SizedBox.shrink()),
            Container(
              width: Dimens.homeAvatarSize,
              height: Dimens.homeAvatarSize,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimens.homeAvatarSize / 2),
              ),
            ),
          ],
        ),
        const Expanded(child: const SizedBox.shrink()),
        _buildFakeTextContent(screenWidth / 10),
        const SizedBox(height: Dimens.defaultMarginPaddingSmall),
        _buildFakeTextContent(screenWidth / 3 * 2),
        const SizedBox(height: 8.0),
        _buildFakeTextContent(screenWidth / 3),
        const SizedBox(height: Dimens.defaultMarginPaddingSmall),
        _buildFakeTextContent(screenWidth / 10 * 9),
        const SizedBox(height: 8.0),
        _buildFakeTextContent(screenWidth / 5 * 3),
        const SizedBox(height: 18.0),
      ],
    );
  }

  Widget _buildFakeTextContent(double width) {
    return Container(
      width: width,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
