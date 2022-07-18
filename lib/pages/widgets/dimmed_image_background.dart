import 'package:flutter/material.dart';
import 'package:flutter_survey/pages/widgets/blur_background.dart';
import 'package:flutter_survey/pages/widgets/dimmed_background.dart';

class DimmedImageBackground extends StatelessWidget {
  final ImageProvider image;
  final bool shouldBlur;

  const DimmedImageBackground({required this.image, this.shouldBlur = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (shouldBlur) BlurBackground(),
        DimmedBackground(
          colors: [
            Colors.black.withOpacity(0.2),
            Colors.black,
          ],
          stops: const [0.0, 1.0],
        ),
      ],
    );
  }
}
