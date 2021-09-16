import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final bool dismissible;

  LoadingIndicator({
    this.dismissible = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: ModalBarrier(
            dismissible: dismissible,
            color: Colors.black54,
          ),
        ),
        Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        ),
      ],
    );
  }
}
