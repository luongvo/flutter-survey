import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/models/oauth_token.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../test/mock/mock_data.mocks.dart';

void main() {
  group('LoginUseCaseTest', () {
    late MockOAuthRepository mockRepository;
    late MockSharedPreferencesHelper mockSharePref;
    late LoginUseCase loginUseCase;

    setUp(() {
      mockRepository = MockOAuthRepository();
      mockSharePref = MockSharedPreferencesHelper();
      loginUseCase = LoginUseCase(mockRepository, mockSharePref);
    });

    test(
        'When logging in with valid email and password, it returns Success result',
        () async {
      when(mockRepository.login(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) async => OAuthToken(
                accessToken: "accessToken",
                tokenType: "tokenType",
                expiresIn: 111,
                refreshToken: "refreshToken",
              ));
      final result = await loginUseCase
          .call(LoginInput(email: 'email', password: 'password'));

      expect(result, isA<Success>());
      verify(mockSharePref.saveTokenType("tokenType")).called(1);
      verify(mockSharePref.saveAccessToken("accessToken")).called(1);
      verify(mockSharePref.saveRefreshToken("refreshToken")).called(1);
      verify(mockSharePref.saveTokenExpiration(any)).called(1);
    });

    test(
        'When logging in with incorrect email or password, it returns Failed result',
        () async {
      when(mockRepository.login(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) => Future.error(
                NetworkExceptions.unauthorisedRequest(),
              ));
      final result = await loginUseCase
          .call(LoginInput(email: 'email', password: 'password'));

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException,
          NetworkExceptions.unauthorisedRequest());
    });
  });
}
