// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OauthTokenResponse _$OauthTokenResponseFromJson(Map<String, dynamic> json) {
  return OauthTokenResponse(
    accessToken: json['access_token'] as String,
    tokenType: json['token_type'] as String,
    expiresIn: json['expires_in'] as int,
    refreshToken: json['refresh_token'] as String,
    createdAt: json['created_at'] as int,
  );
}

Map<String, dynamic> _$OauthTokenResponseToJson(OauthTokenResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'refresh_token': instance.refreshToken,
      'created_at': instance.createdAt,
    };
