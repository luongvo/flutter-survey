// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OAuthTokenResponse _$OAuthTokenResponseFromJson(Map<String, dynamic> json) {
  return OAuthTokenResponse(
    accessToken: json['access_token'] as String,
    tokenType: json['token_type'] as String,
    expiresIn: json['expires_in'] as int,
    refreshToken: json['refresh_token'] as String,
    createdAt: json['created_at'] as int,
  );
}

Map<String, dynamic> _$OAuthTokenResponseToJson(OAuthTokenResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'refresh_token': instance.refreshToken,
      'created_at': instance.createdAt,
    };
