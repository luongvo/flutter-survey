import 'dart:async';

import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/repository/oauth_repository.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ResetPasswordUseCase extends UseCase<void, String> {
  final OAuthRepository _repository;

  const ResetPasswordUseCase(this._repository);

  @override
  Future<Result<void>> call(String email) {
    return _repository
        .resetPassword(email: email)
        .then((value) =>
            Success(null) as Result<void>) // ignore: unnecessary_cast
        .onError<NetworkExceptions>(
            (err, stackTrace) => Failed(UseCaseException(err)));
  }
}
