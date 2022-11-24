import 'package:flutter_survey/api/oauth_service.dart';
import 'package:flutter_survey/api/request/oauth_token_request.dart';
import 'package:flutter_survey/api/response/oauth_token_response.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_data.dart';

const String LOGIN_KEY = 'login';

class FakeOAuthService extends Fake implements BaseOAuthService {
  @override
  Future<OAuthTokenResponse> login(OAuthTokenRequest body) async {
    final response = FakeData.fakeResponses[LOGIN_KEY]!;

    if (response.statusCode != 200) {
      throw fakeDioError(response.statusCode);
    }
    return OAuthTokenResponse.fromJson(response.json);
  }
}
