import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/gen/colors.gen.dart';
import 'package:flutter_survey/pages/login/login_state.dart';
import 'package:flutter_survey/pages/login/login_view_model.dart';
import 'package:flutter_survey/pages/widgets/decoration/custom_input_decoration.dart';
import 'package:flutter_survey/pages/widgets/dimmed_image_background.dart';
import 'package:flutter_survey/pages/widgets/loading_indicator.dart';
import 'package:flutter_survey/resources/dimens.dart';
import 'package:flutter_survey/routes.dart';
import 'package:flutter_survey/usecase/login_use_case.dart';
import 'package:flutter_survey/utils/keyboard_util.dart';

const PASSWORD_LENGTH_MIN = 6;

final loginViewModelProvider =
    StateNotifierProvider.autoDispose<LoginViewModel, LoginState>((ref) {
  return LoginViewModel(getIt.get<LoginUseCase>());
});

class LoginPage extends ConsumerStatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen<LoginState>(loginViewModelProvider, (_, loginState) {
      loginState.maybeWhen(
        error: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.localization.loginError)));
        },
        success: () async {
          await Navigator.of(context).popAndPushNamed(Routes.HOME_PAGE);
        },
        orElse: () {},
      );
    });
    return _buildLoginPage();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildLoginPage() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          DimmedImageBackground(
            image: Assets.images.bgLogin,
            shouldBlur: true,
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.defaultMarginPaddingLarge),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Assets.icons.icNimbleLogo.svg(),
                ),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: _buildLoginForm(),
                ),
                const Expanded(child: SizedBox.shrink()),
              ],
            ),
          ),
          Consumer(builder: (_, WidgetRef ref, __) {
            final loginViewModel = ref.watch(loginViewModelProvider);
            return loginViewModel.maybeWhen(
              loading: () => LoadingIndicator(),
              orElse: () => SizedBox.shrink(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    final forgotButtonWidth = 80.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          autofocus: true,
          controller: _emailController,
          decoration: CustomInputDecoration(
            context: context,
            hint: context.localization.loginEmail,
          ),
          keyboardType: TextInputType.emailAddress,
          style: Theme.of(context).textTheme.bodyText1,
          textInputAction: TextInputAction.next,
          validator: _emailValidator,
        ),
        const SizedBox(height: Dimens.defaultMarginPadding),
        Stack(
          children: [
            TextFormField(
              controller: _passwordController,
              decoration: CustomInputDecoration(
                context: context,
                hint: context.localization.loginPassword,
              ).copyWith(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: Dimens.inputHorizontalPadding,
                  vertical: Dimens.inputVerticalPadding,
                ).copyWith(
                  right: forgotButtonWidth,
                ),
              ),
              obscureText: true,
              obscuringCharacter: "???",
              style: Theme.of(context).textTheme.bodyText1,
              textInputAction: TextInputAction.done,
              validator: _passwordValidator,
              onFieldSubmitted: (_) => _attemptLogin(),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 56,
                child: TextButton(
                  child: Text(
                    context.localization.loginForgot,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorName.whiteAlpha50,
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
            child: Text(context.localization.loginText),
            onPressed: () => _attemptLogin(),
          ),
        ),
      ],
    );
  }

  String? _emailValidator(String? value) {
    if (value == null || !EmailValidator.validate(value)) {
      return context.localization.validationErrorEmailInvalid;
    } else {
      return null;
    }
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.length < PASSWORD_LENGTH_MIN) {
      return context.localization.validationErrorEmailInvalid;
    } else {
      return null;
    }
  }

  Future<void> _attemptLogin() async {
    if (_formKey.currentState!.validate()) {
      KeyboardUtil.hideKeyboard(context);

      ref
          .read(loginViewModelProvider.notifier)
          .login(_emailController.text, _passwordController.text);
    }
  }
}
