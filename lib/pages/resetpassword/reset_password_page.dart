import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/gen/colors.gen.dart';
import 'package:flutter_survey/pages/resetpassword/reset_password_state.dart';
import 'package:flutter_survey/pages/resetpassword/reset_password_view_model.dart';
import 'package:flutter_survey/pages/widgets/decoration/custom_input_decoration.dart';
import 'package:flutter_survey/pages/widgets/dimmed_image_background.dart';
import 'package:flutter_survey/pages/widgets/loading_indicator.dart';
import 'package:flutter_survey/resources/dimens.dart';
import 'package:flutter_survey/usecase/reset_password_use_case.dart';
import 'package:flutter_survey/utils/keyboard_util.dart';

final _resetPasswordViewModelProvider = StateNotifierProvider.autoDispose<
    ResetPasswordViewModel, ResetPasswordState>((ref) {
  return ResetPasswordViewModel(getIt.get<ResetPasswordUseCase>());
});

class ResetPasswordPage extends ConsumerStatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen<ResetPasswordState>(_resetPasswordViewModelProvider, (_, state) {
      state.maybeWhen(
        error: (error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(error ?? context.localization.loginError)));
        },
        success: () async {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(context.localization.resetPasswordSuccess)));
        },
        orElse: () {},
      );
    });
    return _buildPage();
  }

  Widget _buildPage() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          DimmedImageBackground(
            image: Assets.images.bgLogin.image().image,
            shouldBlur: true,
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.defaultMarginPaddingLarge),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.icons.icNimbleLogo.svg(),
                      const SizedBox(height: Dimens.defaultMarginPadding),
                      Text(
                        context.localization.resetPasswordDescription,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: ColorName.whiteAlpha70),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: _buildForm(),
                ),
                Expanded(child: SizedBox.shrink()),
              ],
            ),
          ),
          SafeArea(
            child: GestureDetector(
              onTap: () => context.navigateBack(),
              child: SizedBox(
                width: 56,
                height: 56,
                child: Assets.icons.icBack.svg(
                  fit: BoxFit.none,
                ),
              ),
            ),
          ),
          Consumer(builder: (_, WidgetRef ref, __) {
            final viewModel = ref.watch(_resetPasswordViewModelProvider);
            return viewModel.maybeWhen(
              loading: () => LoadingIndicator(),
              orElse: () => SizedBox.shrink(),
            );
          }),
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
            child: Text(context.localization.resetPasswordText),
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

      ref
          .read(_resetPasswordViewModelProvider.notifier)
          .resetPassword(_emailController.text);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
