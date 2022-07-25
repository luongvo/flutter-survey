import 'package:flutter_survey/api/response/base/base_response_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'oauth_token_response.g.dart';

@JsonSerializable()
class OAuthTokenResponse {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String refreshToken;
  final int createdAt;

  OAuthTokenResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
    required this.createdAt,
  });

  factory OAuthTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$OAuthTokenResponseFromJson(fromJsonApi(json));
}
