import 'package:flutter_survey/api/response/base/base_http_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'oauth_token_response.g.dart';

@JsonSerializable()
class OAuthTokenResponse extends BaseResponse {
  @JsonKey(name: "access_token")
  String accessToken;
  @JsonKey(name: "token_type")
  String tokenType;
  @JsonKey(name: "expires_in")
  int expiresIn;
  @JsonKey(name: "refresh_token")
  String refreshToken;
  @JsonKey(name: "created_at")
  int createdAt;

  OAuthTokenResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
    required this.createdAt,
  });

  factory OAuthTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$OAuthTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OAuthTokenResponseToJson(this);
}
