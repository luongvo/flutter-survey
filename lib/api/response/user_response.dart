import 'package:flutter_survey/api/response/base/base_response_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final String id;
  final String email;
  final String name;
  final String avatarUrl;

  UserResponse({
    required this.id,
    required this.email,
    required this.name,
    required this.avatarUrl,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(fromJsonApi(json));
}
