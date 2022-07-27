import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/get_user_profile_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/mock_data.mocks.dart';

void main() {
  group('GetUserProfileUseCaseTest', () {
    late MockUserRepository mockRepository;
    late GetUserProfileUseCase useCase;

    setUp(() async {
      mockRepository = MockUserRepository();
      useCase = GetUserProfileUseCase(mockRepository);
    });

    test('When calling API with valid data, it returns Success result',
        () async {
      final user = MockUser();

      when(mockRepository.getUserProfile()).thenAnswer((_) async => user);
      final result = await useCase.call();

      expect(result, isA<Success>());
    });

    test('When calling API with invalid data, it returns Failed result',
        () async {
      when(mockRepository.getUserProfile()).thenAnswer((_) => Future.error(
            NetworkExceptions.unauthorisedRequest(),
          ));
      final result = await useCase.call();

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException,
          NetworkExceptions.unauthorisedRequest());
    });
  });
}
