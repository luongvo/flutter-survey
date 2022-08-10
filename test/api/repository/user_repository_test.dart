import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/repository/user_repository.dart';
import 'package:flutter_survey/api/response/user_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mock/mock_data.mocks.dart';
import '../../utils/file_util.dart';

void main() {
  group("UserRepositoryTest", () {
    late MockUserService mockUserService;
    late UserRepository userRepository;

    setUp(() async {
      mockUserService = MockUserService();
      userRepository = UserRepositoryImpl(mockUserService);
    });

    test(
        'When calling getUserProfile successfully, it returns corresponding response',
        () async {
      final userJson = await FileUtil.loadFile('test_resources/user.json');
      final response = UserResponse.fromJson(userJson);

      when(mockUserService.getUserProfile()).thenAnswer((_) async => response);
      final result = await userRepository.getUserProfile();

      expect(result.name, "Luong");
      expect(result.email, "luong@nimblehq.co");
    });

    test(
        'When calling getUserProfile failed, it returns NetworkExceptions error',
        () async {
      when(mockUserService.getUserProfile()).thenThrow(MockDioError());
      final result = () => userRepository.getUserProfile();

      expect(result, throwsA(isA<NetworkExceptions>()));
    });
  });
}
