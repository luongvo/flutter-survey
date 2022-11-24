import 'package:flutter_survey/api/response/user_response.dart';
import 'package:flutter_survey/api/user_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_data.dart';

const String USER_KEY = 'user';

class FakeUserService extends Fake implements BaseUserService {
  @override
  Future<UserResponse> getUserProfile() async {
    final response = FakeData.fakeResponses[USER_KEY]!;

    if (response.statusCode != 200) {
      throw fakeDioError(response.statusCode);
    }
    return UserResponse.fromJson(response.json);
  }
}
