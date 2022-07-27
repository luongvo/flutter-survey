import 'package:json_annotation/json_annotation.dart';

part 'oauth_refresh_token_request.g.dart';

const String _grantTypeRefreshToken = 'refresh_token';

@JsonSerializable()
class OAuthRefreshTokenRequest {
  final String grantType;
  final String clientId;
  final String clientSecret;
  final String refreshToken;

  OAuthRefreshTokenRequest({
    this.grantType = _grantTypeRefreshToken,
    required this.clientId,
    required this.clientSecret,
    required this.refreshToken,
  });

  factory OAuthRefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$OAuthRefreshTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OAuthRefreshTokenRequestToJson(this);
}
