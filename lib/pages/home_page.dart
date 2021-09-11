import 'package:flutter/material.dart';
import 'package:flutter_survey/gen/assets.gen.dart';

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
        ],
      ),
    );
  }
}
