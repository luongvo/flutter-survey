import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/reset_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/mock_data.mocks.dart';

void main() {
  group('ResetPasswordUseCaseTest', () {
    late MockOAuthRepository mockRepository;
    late ResetPasswordUseCase useCase;

    setUp(() async {
      mockRepository = MockOAuthRepository();

      useCase = ResetPasswordUseCase(mockRepository);
    });

    test('When calling API with valid data, it returns Success result',
        () async {
      when(mockRepository.resetPassword(email: anyNamed('email')))
          .thenAnswer((_) async => null);
      final result = await useCase.call('email');

      expect(result, isA<Success>());
    });

    test('When calling API with invalid data, it returns Failed result',
        () async {
      when(mockRepository.resetPassword(email: anyNamed('email')))
          .thenAnswer((_) => Future.error(
                NetworkExceptions.unauthorisedRequest(),
              ));
      final result = await useCase.call('email');

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException,
          NetworkExceptions.unauthorisedRequest());
    });
  });
}
