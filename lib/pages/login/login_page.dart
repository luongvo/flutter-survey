import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/gen/colors.gen.dart';
import 'package:flutter_survey/resources/dimens.dart';
import 'package:flutter_survey/routes.dart';

import '../widgets/blur_background.dart';
import '../widgets/dimmed_background.dart';

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
            padding: const EdgeInsets.all(Dimens.defaultMarginPaddingLarge),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Assets.icons.icNimbleLogo.svg(),
                ),
                _buildLoginForm(context),
                const Expanded(child: SizedBox.shrink()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    final forgotButtonWidth = 80.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          autofocus: true,
          decoration: _formInputDecoration(
            context,
            AppLocalizations.of(context)!.loginEmail,
          ),
          keyboardType: TextInputType.emailAddress,
          style: Theme.of(context).textTheme.bodyText1,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: Dimens.defaultMarginPadding),
        Stack(
          children: [
            TextField(
              decoration: _formInputDecoration(
                context,
                AppLocalizations.of(context)!.loginPassword,
              ).copyWith(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: Dimens.inputHorizontalPadding,
                  vertical: Dimens.inputVerticalPadding,
                ).copyWith(
                  right: forgotButtonWidth,
                ),
              ),
              obscureText: true,
              obscuringCharacter: "●",
              style: Theme.of(context).textTheme.bodyText1,
              textInputAction: TextInputAction.done,
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: double.infinity,
                  child: TextButton(
                    child: Text(
                      AppLocalizations.of(context)!.loginForgot,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: ColorName.whiteAlpha50,
                          ),
                    ),
                    onPressed: () {
                      // TODO forgot https://github.com/luongvo/flutter-survey/issues/8
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimens.defaultMarginPadding),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              foregroundColor: MaterialStateProperty.all(Colors.black),
              overlayColor: MaterialStateProperty.all(Colors.black12),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  vertical: Dimens.inputVerticalPadding,
                ),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimens.inputBorderRadius)),
              ),
              textStyle: MaterialStateProperty.all(
                Theme.of(context).textTheme.button,
              ),
            ),
            child: Text(AppLocalizations.of(context)!.loginText),
            onPressed: () {
              // TODO login https://github.com/luongvo/flutter-survey/issues/7
              Navigator.of(context).pushNamed(Routes.HOME_PAGE);
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
          borderRadius: BorderRadius.circular(
            Dimens.inputBorderRadius,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Dimens.inputHorizontalPadding,
          vertical: Dimens.inputVerticalPadding,
        ),
        fillColor: ColorName.whiteAlpha18,
        filled: true,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: ColorName.whiteAlpha18),
        hintText: hint,
      );

  Widget _buildDimmedBackground() => DimmedBackground(
        colors: [
          Colors.black.withOpacity(0.2),
          Colors.black.withOpacity(0.8),
          Colors.black,
        ],
        stops: const [0.0, 0.6, 1.0],
      );
}
