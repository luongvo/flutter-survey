class OAuthToken {
  String accessToken;
  String refreshToken;
  String tokenType;
  int expiresIn;

  OAuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
  });
}
