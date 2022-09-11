import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/pages/widgets/decoration/custom_input_decoration.dart';
import 'package:flutter_survey/pages/widgets/dimmed_image_background.dart';
import 'package:flutter_survey/resources/dimens.dart';
import 'package:flutter_survey/utils/keyboard_util.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          DimmedImageBackground(
            image: Assets.images.bgLogin.image().image,
            shouldBlur: true,
          ),
          Assets.icons.icNimbleLogo.svg(),
          Padding(
            padding: const EdgeInsets.all(Dimens.defaultMarginPaddingLarge),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: _buildForm(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
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
            child: Text(context.localization.forgotResetText),
            onPressed: () => _attemptResetPassword(),
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

  Future<void> _attemptResetPassword() async {
    if (_formKey.currentState!.validate()) {
      KeyboardUtil.hideKeyboard(context);

      // TODO integration
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
