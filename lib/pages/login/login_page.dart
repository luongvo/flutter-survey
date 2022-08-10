import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/pages/login/login_state.dart';
import 'package:flutter_survey/pages/login/login_view_model.dart';
import 'package:flutter_survey/pages/login/widget/login_form.dart';
import 'package:flutter_survey/pages/widgets/dimmed_image_background.dart';
import 'package:flutter_survey/pages/widgets/loading_indicator.dart';
import 'package:flutter_survey/resources/dimens.dart';
import 'package:flutter_survey/routes.dart';
import 'package:flutter_survey/usecase/login_use_case.dart';

final loginViewModelProvider =
    StateNotifierProvider.autoDispose<LoginViewModel, LoginState>((ref) {
  return LoginViewModel(getIt.get<LoginUseCase>());
});

class LoginPage extends ConsumerStatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    ref.listen<LoginState>(loginViewModelProvider, (_, loginState) {
      loginState.maybeWhen(
        error: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.localization.loginError)));
        },
        success: () async {
          await Navigator.of(context).popAndPushNamed(Routes.home);
        },
        orElse: () {},
      );
    });
    return ref.watch(loginViewModelProvider).maybeWhen(
          init: () => _buildSplashPage(),
          orElse: () => _buildLoginPage(),
        );
  }

  Widget _buildSplashPage() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          DimmedImageBackground(
            image: Assets.images.bgLogin.image().image,
          ),
          Align(
            alignment: Alignment.center,
            child: Assets.icons.icNimbleLogo.svg(),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginPage() {
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
              children: <Widget>[
                Expanded(
                  child: Assets.icons.icNimbleLogo.svg(),
                ),
                LoginForm(),
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
}
