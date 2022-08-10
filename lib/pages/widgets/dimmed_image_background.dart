import 'package:flutter/material.dart';
import 'package:flutter_survey/pages/widgets/blur_background.dart';
import 'package:flutter_survey/pages/widgets/dimmed_background.dart';

class DimmedImageBackground extends StatefulWidget {
  final ImageProvider image;
  final bool shouldBlur;
  final Animation<double>? backgroundAnimation;

  const DimmedImageBackground({
    required this.image,
    this.shouldBlur = false,
    this.backgroundAnimation = null,
  });

  @override
  _DimmedImageBackgroundState createState() => _DimmedImageBackgroundState();
}

class _DimmedImageBackgroundState extends State<DimmedImageBackground> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: widget.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (widget.shouldBlur)
          if (widget.backgroundAnimation != null)
            FadeTransition(
              opacity: widget.backgroundAnimation!,
              child: _buildBlurBackground(),
            )
          else
            _buildBlurBackground(),
        if (widget.backgroundAnimation != null)
          FadeTransition(
            opacity: widget.backgroundAnimation!,
            child: _buildDimmedBackground(),
          )
        else
          _buildDimmedBackground(),
      ],
    );
  }

  Widget _buildBlurBackground() => BlurBackground();

  Widget _buildDimmedBackground() {
    return DimmedBackground(
      colors: [
        Colors.black.withOpacity(0.2),
        Colors.black,
      ],
      stops: const [0.0, 1.0],
    );
  }
}
