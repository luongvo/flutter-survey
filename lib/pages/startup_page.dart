import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/local/shared_preference_helper.dart';
import 'package:flutter_survey/pages/home/home_page.dart';
import 'package:flutter_survey/pages/login/login_page.dart';

final sharedPreferencesProvider =
    Provider.autoDispose<SharedPreferencesHelper>((ref) {
  return getIt.get<SharedPreferencesHelper>();
});

class StartupPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharedPreferenceHelper = ref.watch(sharedPreferencesProvider);
    if (sharedPreferenceHelper.isLoggedIn) {
      return HomePage();
    }
    return LoginPage();
  }
}
