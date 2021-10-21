import 'package:equatable/equatable.dart';

class OAuthToken extends Equatable {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;

  OAuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
  });

  @override
  List<Object> get props => [accessToken, refreshToken, tokenType, expiresIn];
}
