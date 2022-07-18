import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/repository/user_repository.dart';
import 'package:flutter_survey/models/user.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetUserProfileUseCase extends UseCase<User, void> {
  final UserRepository _userRepository;

  const GetUserProfileUseCase(this._userRepository);

  @override
  Future<Result<User>> call(void params) {
    return _userRepository
        .getUserProfile()
        .then((value) =>
            Success(value) as Result<User>) // ignore: unnecessary_cast
        .onError<NetworkExceptions>(
            (err, stackTrace) => Failed(UseCaseException(err)));
  }
}
