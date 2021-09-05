import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey/resouces/assets.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.bgLogin),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CupertinoTextField(
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 100,
                    // TODO localization https://github.com/luongvo/flutter-survey/issues/25
                    placeholder: "Email",
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  CupertinoTextField(
                    maxLength: 100,
                    obscureText: true,
                    placeholder: "Password",
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Flexible(
                    child: FractionallySizedBox(
                      widthFactor: 1.0,
                      child: CupertinoButton(
                        color: Colors.blue,
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          // TODO login https://github.com/luongvo/flutter-survey/issues/7
                        },
                        child: Text('Log in'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
