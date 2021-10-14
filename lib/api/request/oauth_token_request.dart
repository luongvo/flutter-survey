import 'package:json_annotation/json_annotation.dart';

part 'oauth_token_request.g.dart';

const String GRANT_TYPE_PASSWORD = "password";

@JsonSerializable()
class OAuthTokenRequest {
  @JsonKey(name: 'grant_type')
  final String grantType;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'client_secret')
  final String clientSecret;

  OAuthTokenRequest({
    this.grantType = GRANT_TYPE_PASSWORD,
    required this.email,
    required this.password,
    required this.clientId,
    required this.clientSecret,
  });

  factory OAuthTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$OAuthTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OAuthTokenRequestToJson(this);
}
