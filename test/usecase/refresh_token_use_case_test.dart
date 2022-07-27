import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/models/oauth_token.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/refresh_token_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../test/mock/mock_data.mocks.dart';
import '../fake/fake_shared_preference_helper.dart';

void main() {
  group('RefreshTokenUseCaseTest', () {
    late MockOAuthRepository mockRepository;
    late FakeSharedPreferencesHelper fakeSharePref;
    late RefreshTokenUseCase useCase;

    setUp(() {
      mockRepository = MockOAuthRepository();
      fakeSharePref = FakeSharedPreferencesHelper();
      useCase = RefreshTokenUseCase(mockRepository, fakeSharePref);
    });

    test('When calling refresh token successfully, it returns Success result',
        () async {
      when(mockRepository.refreshToken(refreshToken: anyNamed('refreshToken')))
          .thenAnswer((_) async => OAuthToken(
                accessToken: "accessToken",
                tokenType: "tokenType",
                expiresIn: 111,
                refreshToken: "refreshToken",
              ));
      final result = await useCase.call();

      expect(result, isA<Success>());
    });

    test('When calling refresh token failed, it returns Failed result',
        () async {
      when(mockRepository.refreshToken(refreshToken: anyNamed('refreshToken')))
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
