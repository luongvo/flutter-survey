import 'package:json_annotation/json_annotation.dart';

part 'oauth_token_request.g.dart';

const String GRANT_TYPE_PASSWORD = "password";

@JsonSerializable()
class OauthTokenRequest {
  @JsonKey(name: 'grant_type')
  String grantType;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'password')
  String password;
  @JsonKey(name: 'client_id')
  String clientId;
  @JsonKey(name: 'client_secret')
  String clientSecret;

  OauthTokenRequest({
    this.grantType = GRANT_TYPE_PASSWORD,
    required this.email,
    required this.password,
    required this.clientId,
    required this.clientSecret,
  });

  factory OauthTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$OauthTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OauthTokenRequestToJson(this);
}
