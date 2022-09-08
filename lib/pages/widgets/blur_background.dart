import 'dart:ui';

import 'package:flutter/material.dart';

class BlurBackground extends StatefulWidget {
  final Animation<double>? backgroundAnimation;

  const BlurBackground({
    this.backgroundAnimation = null,
  });

  @override
  _BlurBackgroundState createState() => _BlurBackgroundState();
}

class _BlurBackgroundState extends State<BlurBackground> {
  @override
  void initState() {
    if (widget.backgroundAnimation != null) {
      widget.backgroundAnimation!
        ..addListener(() {
          setState(() {});
        });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sigma = (widget.backgroundAnimation?.value ?? 1) * 15.0;
    return Container(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: Container(
          color: Colors.white10,
        ),
      ),
    );
  }
}
