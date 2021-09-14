import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/gen/colors.gen.dart';
import 'package:flutter_survey/pages/login/login_model.dart';
import 'package:flutter_survey/pages/login/login_state.dart';
import 'package:flutter_survey/pages/widgets/decoration/custom_input_decoration.dart';
import 'package:flutter_survey/resources/dimens.dart';
import 'package:flutter_survey/routes.dart';
import 'package:flutter_survey/usecase/login_use_case.dart';

import '../widgets/blur_background.dart';
import '../widgets/dimmed_background.dart';

final loginModelProvider =
    StateNotifierProvider.autoDispose<LoginModel, LoginState>((ref) {
  return LoginModel(getIt.get<LoginUseCase>());
});

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ProviderListener(
        provider: loginModelProvider,
        onChange: (BuildContext ctx, LoginState loginState) {
          loginState.maybeWhen(
            error: (error) {
              // TODO error
            },
            success: () async {
              await Navigator.of(context).pushNamed(Routes.HOME_PAGE);
            },
            orElse: () {},
          );
        },
        child: _buildLoginPage(context));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildLoginPage(BuildContext context) {
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
          DimmedBackground(
            colors: [
              Colors.black.withOpacity(0.2),
              Colors.black.withOpacity(0.8),
              Colors.black,
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
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
          controller: _emailController,
          decoration: CustomInputDecoration(
            context: context,
            hint: AppLocalizations.of(context)!.loginEmail,
          ),
          keyboardType: TextInputType.emailAddress,
          style: Theme.of(context).textTheme.bodyText1,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: Dimens.defaultMarginPadding),
        Stack(
          children: [
            TextField(
              controller: _passwordController,
              decoration: CustomInputDecoration(
                context: context,
                hint: AppLocalizations.of(context)!.loginPassword,
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
              onSubmitted: (_) => _attemptLogin(),
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
            onPressed: () => _attemptLogin(),
          ),
        ),
      ],
    );
  }

  void _attemptLogin() {
    final LoginModel loginModel =
        context.read<LoginModel>(loginModelProvider.notifier);
    loginModel.login(_emailController.text, _passwordController.text);
  }
}
