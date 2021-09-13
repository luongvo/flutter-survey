// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OauthTokenRequest _$OauthTokenRequestFromJson(Map<String, dynamic> json) {
  return OauthTokenRequest(
    grantType: json['grant_type'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    clientId: json['client_id'] as String,
    clientSecret: json['client_secret'] as String,
  );
}

Map<String, dynamic> _$OauthTokenRequestToJson(OauthTokenRequest instance) =>
    <String, dynamic>{
      'grant_type': instance.grantType,
      'email': instance.email,
      'password': instance.password,
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
    };
