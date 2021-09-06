import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/resouces/app_colors.dart';

import 'widgets/blur_background.dart';
import 'widgets/dimmed_background.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Assets.images.bgLogin,
                fit: BoxFit.cover,
              ),
            ),
          ),
          BlurBackground(),
          _buildDimmedBackground(),
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Assets.icons.icNimbleLogo.svg(),
                ),
                _buildLoginForm(context),
                Expanded(
                  child: SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          autofocus: true,
          // TODO localization https://github.com/luongvo/flutter-survey/issues/25
          decoration: _formInputDecoration(context, "Email"),
          keyboardType: TextInputType.emailAddress,
          style: Theme.of(context).textTheme.bodyText1,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(
          height: 20.0,
        ),
        Stack(
          children: [
            TextField(
              decoration: _formInputDecoration(context, "Password"),
              obscureText: true,
              obscuringCharacter: "●",
              style: Theme.of(context).textTheme.bodyText1,
              textInputAction: TextInputAction.done,
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: Text(
                    "Forgot?",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 15,
                        ),
                  ),
                  onPressed: () {
                    // TODO forgot https://github.com/luongvo/flutter-survey/issues/8
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          width: double.infinity,
          child: CupertinoButton(
            color: Colors.blue,
            padding: EdgeInsets.all(0),
            child: Text(
              'Log in',
              style: Theme.of(context).textTheme.button,
            ),
            onPressed: () {
              // TODO login https://github.com/luongvo/flutter-survey/issues/7
            },
          ),
        ),
      ],
    );
  }

  InputDecoration _formInputDecoration(BuildContext context, String hint) =>
      InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.0),
        ),
        fillColor: AppColors.whiteAlpha18,
        filled: true,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: AppColors.whiteAlpha18),
        hintText: hint,
      );

  Widget _buildDimmedBackground() => DimmedBackground(
        colors: [
          Colors.black.withOpacity(0.2),
          Colors.black.withOpacity(0.8),
          Colors.black,
        ],
        stops: [0.0, 0.6, 1.0],
      );
}
