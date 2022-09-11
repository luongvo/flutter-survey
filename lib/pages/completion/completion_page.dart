import 'package:flutter/material.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/gen/colors.gen.dart';
import 'package:lottie/lottie.dart';

class CompletionPage extends StatefulWidget {
  const CompletionPage({Key? key}) : super(key: key);

  @override
  State<CompletionPage> createState() => _CompletionPageState();
}

class _CompletionPageState extends State<CompletionPage>
    with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        });

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorName.blackRussian,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: SizedBox.shrink()),
          Lottie.asset(
            'assets/lotties/completion_success.json',
            width: 200,
            height: 200,
            fit: BoxFit.fill,
            controller: _animationController,
            onLoaded: (composition) {
              _animationController
                ..duration = composition.duration
                ..forward();
            },
          ),
          Text(
            context.localization.completionThanks,
            style:
                Theme.of(context).textTheme.headline5!.copyWith(fontSize: 28.0),
            textAlign: TextAlign.center,
          ),
          Expanded(child: SizedBox.shrink()),
        ],
      ),
    );
  }
}
