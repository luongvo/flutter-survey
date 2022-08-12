import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/models/oauth_token.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/refresh_token_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../test/mock/mock_data.mocks.dart';

void main() {
  group('RefreshTokenUseCaseTest', () {
    late MockOAuthRepository mockRepository;
    late MockSharedPreferencesHelper mockSharePref;
    late RefreshTokenUseCase useCase;

    setUp(() {
      mockRepository = MockOAuthRepository();
      mockSharePref = MockSharedPreferencesHelper();

      when(mockSharePref.getRefreshToken())
          .thenAnswer((_) async => "refreshToken");

      useCase = RefreshTokenUseCase(mockRepository, mockSharePref);
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
      verify(mockSharePref.saveTokenType("tokenType")).called(1);
      verify(mockSharePref.saveAccessToken("accessToken")).called(1);
      verify(mockSharePref.saveRefreshToken("refreshToken")).called(1);
      verify(mockSharePref.saveTokenExpiration(any)).called(1);
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
