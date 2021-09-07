import 'package:flutter/material.dart';

class DimmedBackground extends StatelessWidget {
  final List<Color> colors;
  final List<double> stops;

  const DimmedBackground({required this.colors, required this.stops});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: colors,
            stops: stops),
      ),
    );
  }
}
