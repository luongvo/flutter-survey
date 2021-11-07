import 'package:dio/dio.dart';
import 'package:flutter_survey/api/response/base/base_http_response.dart';
import 'package:flutter_survey/api/response/survey_response.dart';
import 'package:retrofit/retrofit.dart';

part 'survey_service.g.dart';

class SurveyApi {
  SurveyApi._();
}

@RestApi()
abstract class SurveyService {
  factory SurveyService(Dio dio, {String baseUrl}) = _SurveyService;

  @GET('/v1/surveys?page[number]={pageNumber}&page[size]={pageSize}')
  Future<BaseHttpResponseList<SurveyResponse>> getSurveyList(
    @Path('pageNumber') int pageNumber,
    @Path('pageSize') int pageSize,
  );
}