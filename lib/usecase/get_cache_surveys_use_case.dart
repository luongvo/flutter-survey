import 'package:flutter_survey/local/database/survey_box_helper.dart';
import 'package:flutter_survey/models/survey.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetCacheSurveysUseCase extends SimpleUseCase<List<Survey>> {
  final SurveyBoxHelper _surveyBoxHelper;

  GetCacheSurveysUseCase(this._surveyBoxHelper);

  @override
  List<Survey> call() {
    return _surveyBoxHelper.surveys;
  }
}
