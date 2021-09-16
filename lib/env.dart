import 'package:flutter_config/flutter_config.dart';

class Env {
  static String get restApiEndpoint {
    return FlutterConfig.get('REST_API_ENDPOINT');
  }

  static String get basicAuthClientId {
    return FlutterConfig.get('BASIC_AUTH_CLIENT_ID');
  }

  static String get basicAuthClientSecret {
    return FlutterConfig.get('BASIC_AUTH_CLIENT_SECRET');
  }
}
