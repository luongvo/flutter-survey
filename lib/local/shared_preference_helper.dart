import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREF_KEY_TYPE = 'PREF_KEY_TYPE';
const String PREF_KEY_ACCESS_TOKEN = 'PREF_KEY_TOKEN';
const String PREF_KEY_REFRESH_TOKEN = 'PREF_KEY_REFRESH_TOKEN';
const String PREF_KEY_TOKEN_EXPIRATION = 'PREF_KEY_TOKEN_EXPIRATION';

abstract class SharedPreferencesHelper {
  Future<String> getTokenType();

  Future<void> saveTokenType(String tokenType);

  Future<String> getAccessToken();

  Future<void> saveAccessToken(String token);

  Future<String> getRefreshToken();

  Future<void> saveRefreshToken(String refreshToken);

  Future<int> getTokenExpiration();

  Future<void> saveTokenExpiration(int expiration);

  Future<void> clear();

  bool get isLoggedIn;
}

@Singleton(as: SharedPreferencesHelper)
class SharedPreferencesHelperImpl implements SharedPreferencesHelper {
  late SharedPreferences _prefs;

  SharedPreferencesHelperImpl(this._prefs);

  @override
  Future<String> getTokenType() async {
    return _prefs.getString(PREF_KEY_TYPE) ?? "";
  }

  @override
  Future<bool> saveTokenType(String tokenType) async {
    return await _prefs.setString(PREF_KEY_TYPE, tokenType);
  }

  @override
  Future<String> getAccessToken() async {
    return _prefs.getString(PREF_KEY_ACCESS_TOKEN) ?? "";
  }

  @override
  Future<bool> saveAccessToken(String token) async {
    return await _prefs.setString(PREF_KEY_ACCESS_TOKEN, token);
  }

  @override
  Future<String> getRefreshToken() async {
    return _prefs.getString(PREF_KEY_REFRESH_TOKEN) ?? "";
  }

  @override
  Future<bool> saveRefreshToken(String refreshToken) async {
    return await _prefs.setString(PREF_KEY_REFRESH_TOKEN, refreshToken);
  }

  @override
  Future<int> getTokenExpiration() async {
    return _prefs.getInt(PREF_KEY_TOKEN_EXPIRATION) ?? 0;
  }

  @override
  Future<bool> saveTokenExpiration(int expiration) async {
    return await _prefs.setInt(PREF_KEY_TOKEN_EXPIRATION, expiration);
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }

  @override
  bool get isLoggedIn {
    return _prefs.containsKey(PREF_KEY_ACCESS_TOKEN) &&
        _prefs.containsKey(PREF_KEY_TYPE);
  }
}
