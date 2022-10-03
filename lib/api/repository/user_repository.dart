import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/user_service.dart';
import 'package:flutter_survey/models/user.dart';
import 'package:injectable/injectable.dart';

abstract class UserRepository {
  Future<User> getUserProfile();
}

@LazySingleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  BaseUserService _userService;

  UserRepositoryImpl(this._userService);

  @override
  Future<User> getUserProfile() async {
    try {
      final response = await _userService.getUserProfile();
      return User.fromUserResponse(response);
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
