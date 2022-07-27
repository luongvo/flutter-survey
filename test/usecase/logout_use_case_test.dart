import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/logout_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../fake/fake_shared_preference_helper.dart';
import '../mock/mock_data.mocks.dart';

void main() {
  group('LogoutUseCaseTest', () {
    late MockOAuthRepository mockRepository;
    late FakeSharedPreferencesHelper fakeSharePref;
    late LogoutUseCase useCase;

    setUp(() async {
      mockRepository = MockOAuthRepository();
      fakeSharePref = FakeSharedPreferencesHelper();

      useCase = LogoutUseCase(mockRepository, fakeSharePref);
    });

    test('When calling API with valid data, it returns Success result',
        () async {
      when(mockRepository.logout(token: anyNamed('token')))
          .thenAnswer((_) async => null);
      final result = await useCase.call();

      expect(result, isA<Success>());
    });

    test('When calling API with invalid data, it returns Failed result',
        () async {
      when(mockRepository.logout(token: anyNamed('token')))
          .thenAnswer((_) => Future.error(
                NetworkExceptions.unauthorisedRequest(),
              ));
      final result = await useCase.call();

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException,
          NetworkExceptions.unauthorisedRequest());
    });
  });
}
