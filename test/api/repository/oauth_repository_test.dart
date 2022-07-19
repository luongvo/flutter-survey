import 'dart:ffi';

import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/repository/oauth_repository.dart';
import 'package:flutter_survey/api/response/oauth_token_response.dart';
import 'package:flutter_survey/models/oauth_token.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mock/mock_data.mocks.dart';

void main() {
  FlutterConfig.loadValueForTesting({
    'BASIC_AUTH_CLIENT_ID': 'CLIENT_ID',
    'BASIC_AUTH_CLIENT_SECRET': 'CLIENT_SECRET',
  });

  group("OAuthRepositoryTest", () {
    late MockOAuthService mockOAuthService;
    late OAuthRepository oauthRepository;

    setUp(() async {
      mockOAuthService = MockOAuthService();
      oauthRepository = OAuthRepositoryImpl(mockOAuthService);
    });

    test(
        'When calling login successfully, it returns corresponding mapped result',
        () async {
      final oauthTokenResponse = OAuthTokenResponse(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        expiresIn: 0,
        refreshToken: 'refreshToken',
        createdAt: 0,
      );
      final expectedValue = OAuthToken(
        accessToken: 'accessToken',
        refreshToken: 'refreshToken',
        tokenType: 'tokenType',
        expiresIn: 0,
      );
      when(mockOAuthService.login(any))
          .thenAnswer((_) async => oauthTokenResponse);

      final result = await oauthRepository.login(
        email: "email",
        password: "password",
      );
      expect(result, expectedValue);
    });

    test('When calling login failed, it returns NetworkExceptions error',
        () async {
      when(mockOAuthService.login(any)).thenThrow(MockDioError());

      final result = () => oauthRepository.login(
            email: "email",
            password: "password",
          );
      expect(result, throwsA(isA<NetworkExceptions>()));
    });

    test('When calling logout successfully, it returns empty result', () async {
      when(mockOAuthService.logout(any)).thenAnswer((_) async => Void);

      await oauthRepository.logout(token: 'token');
    });

    test('When calling logout failed, it returns NetworkExceptions error',
        () async {
      when(mockOAuthService.logout(any)).thenThrow(MockDioError());

      final result = () => oauthRepository.logout(token: 'token');

      expect(result, throwsA(isA<NetworkExceptions>()));
    });
  });
}
