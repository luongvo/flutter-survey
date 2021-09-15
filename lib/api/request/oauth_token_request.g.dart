// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OAuthTokenRequest _$OAuthTokenRequestFromJson(Map<String, dynamic> json) {
  return OAuthTokenRequest(
    grantType: json['grant_type'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    clientId: json['client_id'] as String,
    clientSecret: json['client_secret'] as String,
  );
}

Map<String, dynamic> _$OAuthTokenRequestToJson(OAuthTokenRequest instance) =>
    <String, dynamic>{
      'grant_type': instance.grantType,
      'email': instance.email,
      'password': instance.password,
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
    };
