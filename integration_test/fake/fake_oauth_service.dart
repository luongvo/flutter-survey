import 'package:flutter_survey/api/oauth_service.dart';
import 'package:flutter_survey/api/request/oauth_token_request.dart';
import 'package:flutter_survey/api/response/oauth_token_response.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_data.dart';

class FakeOAuthService extends Fake implements BaseOAuthService {
  @override
  Future<OAuthTokenResponse> login(OAuthTokenRequest body) async {
    await Future.delayed(Duration(milliseconds: 300));
    final loginResponse = FakeData.fakeResponses[LOGIN_KEY]!;

    if (loginResponse.statusCode != 200) {
      throw dioError(loginResponse.statusCode);
    }
    return OAuthTokenResponse.fromJson(loginResponse.json);
  }
}
