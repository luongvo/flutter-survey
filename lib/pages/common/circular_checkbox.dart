import 'package:flutter/material.dart';

class CircularCheckBox extends StatelessWidget {
  final bool isChecked;
  final Function onTap;

  const CircularCheckBox({
    Key? key,
    required this.isChecked,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2, color: Colors.white),
        ),
        child: isChecked
            ? Icon(
                Icons.check,
                size: 20.0,
                color: Colors.white,
              )
            : Icon(
                Icons.check,
                size: 20.0,
                color: Colors.white24,
              ),
      ),
    );
  }
}
