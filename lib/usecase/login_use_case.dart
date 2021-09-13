import 'dart:async';

import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/repository/oauth_repository.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:injectable/injectable.dart';

class LoginInput {
  final String email;
  final String password;

  LoginInput({required this.email, required this.password});
}

@Injectable()
class LoginUseCase extends UseCase<void, LoginInput> {
  final OauthRepository _repository;

  const LoginUseCase(this._repository);

  @override
  Future<Result<void>> call(LoginInput credential) {
    return _repository
        .login(email: credential.email, password: credential.password)
        .then((value) =>
            Success(null) as Result<void>) // ignore: unnecessary_cast
        .onError<Exception>((err, stackTrace) => Failed(
            UseCaseException(NetworkExceptions.fromDioException(err), err)));
  }
}
