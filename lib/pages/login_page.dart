import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/pages/widgets/blur_background.dart';
import 'package:flutter_survey/pages/widgets/dimmed_background.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: Stack(
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
          DimmedBackground(
            colors: [
              Colors.black.withOpacity(0.2),
              Colors.black.withOpacity(0.8),
              Colors.black,
            ],
            stops: [0.0, 0.6, 1.0],
          ),
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Assets.icons.icNimbleLogo.svg(),
                ),
                _buildLoginForm(),
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

  Widget _buildLoginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CupertinoTextField(
          autofocus: true,
          keyboardType: TextInputType.emailAddress,
          maxLength: 100,
          // TODO localization https://github.com/luongvo/flutter-survey/issues/25
          placeholder: "Email",
          textInputAction: TextInputAction.next,
        ),
        SizedBox(
          height: 20.0,
        ),
        Stack(
          children: [
            CupertinoTextField(
              maxLength: 100,
              obscureText: true,
              placeholder: "Password",
              textInputAction: TextInputAction.done,
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: Text(
                    "Forgot?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
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
            onPressed: () {
              // TODO login https://github.com/luongvo/flutter-survey/issues/7
            },
            child: Text('Log in'),
          ),
        ),
      ],
    );
  }
}
