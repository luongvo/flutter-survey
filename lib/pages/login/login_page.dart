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

const _firstPhaseAnimationDuration = Duration(milliseconds: 800);
const _stayPhaseDuration = Duration(milliseconds: 500);
const _lastPhaseAnimationDuration = Duration(milliseconds: 500);

final loginViewModelProvider =
    StateNotifierProvider.autoDispose<LoginViewModel, LoginState>((ref) {
  return LoginViewModel(getIt.get<LoginUseCase>());
});

final _isAnimatedPositionProvider =
    StateProvider.autoDispose<bool>((_) => false);

class LoginPageKey {
  LoginPageKey._();

  static final tfEmail = Key('tfLoginEmail');
  static final tfPassword = Key('tfLoginPassword');
  static final btLogin = Key('btLogin');
}

class LoginPage extends ConsumerStatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with TickerProviderStateMixin {
  late final AnimationController _logoAnimationController = AnimationController(
    duration: _firstPhaseAnimationDuration,
    vsync: this,
  )..forward();
  late final Animation<double> _logoAnimation = CurvedAnimation(
    parent: _logoAnimationController,
    curve: Curves.linear,
  )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(_stayPhaseDuration, () {
          final selectedIndexState =
              ref.read(_isAnimatedPositionProvider.notifier);
          selectedIndexState.state = !selectedIndexState.state;
          _backgroundAnimationController.forward();
        });
      }
    });

  late final AnimationController _backgroundAnimationController =
      AnimationController(
    duration: _lastPhaseAnimationDuration,
    vsync: this,
  );
  late final Animation<double> _backgroundAnimation = CurvedAnimation(
    parent: _backgroundAnimationController,
    curve: Curves.easeIn,
  );

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
    return _buildLoginPage();
  }

  Widget _buildLoginPage() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          DimmedImageBackground(
            image: Assets.images.bgLogin.image().image,
            shouldBlur: true,
            backgroundAnimation: _backgroundAnimation,
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.defaultMarginPaddingLarge),
            child: FadeTransition(
              opacity: _backgroundAnimation,
              child: LoginForm(),
            ),
          ),
          Consumer(
            builder: (_, widgetRef, __) {
              final isAnimatedPosition =
                  widgetRef.watch(_isAnimatedPositionProvider);
              return AnimatedPositioned(
                duration: _lastPhaseAnimationDuration,
                curve: Curves.easeIn,
                child: Center(
                  child: AnimatedScale(
                    duration: _lastPhaseAnimationDuration,
                    scale: isAnimatedPosition ? 1.0 : 1.2,
                    curve: Curves.easeIn,
                    child: FadeTransition(
                      opacity: _logoAnimation,
                      child: Assets.icons.icNimbleLogo.svg(),
                    ),
                  ),
                ),
                bottom: 0.0,
                right: 0.0,
                left: 0.0,
                top: isAnimatedPosition ? -500 : 0.0,
              );
            },
          ),
          Consumer(builder: (_, WidgetRef widgetRef, __) {
            final loginViewModel = widgetRef.watch(loginViewModelProvider);
            return loginViewModel.maybeWhen(
              loading: () => LoadingIndicator(),
              orElse: () => SizedBox.shrink(),
            );
          }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _backgroundAnimationController.dispose();
    super.dispose();
  }
}
