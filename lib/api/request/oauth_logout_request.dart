import 'package:json_annotation/json_annotation.dart';

part 'oauth_logout_request.g.dart';

@JsonSerializable()
class OAuthLogoutRequest {
  String token;
  String clientId;
  String clientSecret;

  OAuthLogoutRequest({
    required this.token,
    required this.clientId,
    required this.clientSecret,
  });

  factory OAuthLogoutRequest.fromJson(Map<String, dynamic> json) =>
      _$OAuthLogoutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OAuthLogoutRequestToJson(this);
}
