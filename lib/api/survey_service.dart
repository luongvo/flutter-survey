import 'package:dio/dio.dart';
import 'package:flutter_survey/api/request/submit_survey_request.dart';
import 'package:flutter_survey/api/response/survey_detail_response.dart';
import 'package:flutter_survey/api/response/surveys_response.dart';
import 'package:retrofit/retrofit.dart';

part 'survey_service.g.dart';

class SurveyApi {
  SurveyApi._();
}

@RestApi()
abstract class SurveyService {
  factory SurveyService(Dio dio, {String baseUrl}) = _SurveyService;

  @GET('/v1/surveys?page[number]={pageNumber}&page[size]={pageSize}')
  Future<SurveysResponse> getSurveyList(
    @Path('pageNumber') int pageNumber,
    @Path('pageSize') int pageSize,
  );

  @GET('/v1/surveys/{surveyId}')
  Future<SurveyDetailResponse> getSurveyDetail(
    @Path('surveyId') String surveyId,
  );

  @POST('/v1/responses')
  Future<void> submitSurvey(@Body() SubmitSurveyRequest body);
}
