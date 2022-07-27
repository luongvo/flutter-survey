import 'dart:collection';

import 'package:flutter_survey/local/shared_preference_helper.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeSharedPreferencesHelper extends Fake
    implements SharedPreferencesHelper {
  Map<String, dynamic> _fakeSharePrefHelper = HashMap();

  @override
  Future<bool> saveTokenType(String tokenType) async {
    _fakeSharePrefHelper[PREF_KEY_TYPE] = tokenType;
    return true;
  }

  @override
  Future<String> getAccessToken() async {
    return 'token';
  }

  @override
  Future<bool> saveAccessToken(String token) async {
    _fakeSharePrefHelper[PREF_KEY_ACCESS_TOKEN] = token;
    return true;
  }

  @override
  Future<String> getRefreshToken() async {
    return 'refreshToken';
  }

  @override
  Future<bool> saveRefreshToken(String refreshToken) async {
    _fakeSharePrefHelper[PREF_KEY_REFRESH_TOKEN] = refreshToken;
    return true;
  }

  @override
  Future<bool> saveTokenExpiration(int expiration) async {
    _fakeSharePrefHelper[PREF_KEY_TOKEN_EXPIRATION] = expiration;
    return true;
  }

  @override
  Future<void> clear() async {
    _fakeSharePrefHelper.clear();
  }
}
