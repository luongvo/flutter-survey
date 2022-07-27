import 'package:equatable/equatable.dart';
import 'package:flutter_survey/api/response/user_response.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String avatarUrl;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        avatarUrl,
      ];

  factory User.fromUserResponse(UserResponse response) {
    return User(
      id: response.id,
      email: response.email,
      name: response.name,
      avatarUrl: response.avatarUrl,
    );
  }
}
