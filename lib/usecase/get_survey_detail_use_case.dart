import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/repository/survey_repository.dart';
import 'package:flutter_survey/models/survey.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:injectable/injectable.dart';

class GetSurveyDetailInput {
  String surveyId;

  GetSurveyDetailInput({
    required this.surveyId,
  });
}

@Injectable()
class GetSurveyDetailUseCase extends UseCase<Survey, GetSurveyDetailInput> {
  final SurveyRepository _surveyRepository;

  const GetSurveyDetailUseCase(this._surveyRepository);

  @override
  Future<Result<Survey>> call(GetSurveyDetailInput params) {
    return _surveyRepository
        .getSurveyDetail(params.surveyId)
        .then((value) =>
            Success(value) as Result<Survey>) // ignore: unnecessary_cast
        .onError<NetworkExceptions>(
            (err, stackTrace) => Failed(UseCaseException(err)));
  }
}
