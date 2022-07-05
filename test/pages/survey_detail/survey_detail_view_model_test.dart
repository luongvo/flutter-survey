import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/response/survey_detail_response.dart';
import 'package:flutter_survey/models/survey_detail.dart';
import 'package:flutter_survey/pages/surveydetail/survey_detail_page.dart';
import 'package:flutter_survey/pages/surveydetail/survey_detail_state.dart';
import 'package:flutter_survey/pages/surveydetail/survey_detail_view_model.dart';
import 'package:flutter_survey/pages/uimodel/survey_ui_model.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test/mock/mock_data.mocks.dart';
import '../../mock/survey_ui_model_mocks.dart';
import '../../utils/file_util.dart';

void main() {
  group('SurveyDetailViewModelTest', () {
    late MockGetSurveyDetailUseCase mockGetSurveyDetailUseCase;
    late ProviderContainer container;

    setUp(() {
      mockGetSurveyDetailUseCase = MockGetSurveyDetailUseCase();
      container = ProviderContainer(
        overrides: [
          surveyDetailViewModelProvider.overrideWithValue(
              SurveyDetailViewModel(mockGetSurveyDetailUseCase)),
        ],
      );
      addTearDown(container.dispose);
    });

    test('When initializing, it initializes with Init state', () {
      expect(container.read(surveyDetailViewModelProvider),
          SurveyDetailState.init());
    });

    test(
        'When loading Survey data from arguments, it initializes with initial Survey data and load the latest Survey detail',
        () async {
      final surveyDetailJson =
          await FileUtil.loadFile('test_resources/survey_detail.json');
      final surveyDetailResponse =
          SurveyDetailResponse.fromJson(surveyDetailJson);
      final surveyDetail =
          SurveyDetail.fromSurveyDetailResponse(surveyDetailResponse);
      final surveyUiModel = SurveyUiModelMocks.mock();

      when(mockGetSurveyDetailUseCase.call(any))
          .thenAnswer((_) async => Success(surveyDetail));
      final stateStream =
          container.read(surveyDetailViewModelProvider.notifier).stream;
      final surveyStream =
          container.read(surveyDetailViewModelProvider.notifier).surveyStream;

      expect(
          stateStream,
          emitsInOrder([
            SurveyDetailState.loading(),
            SurveyDetailState.success(),
            SurveyDetailState.loading(),
            SurveyDetailState.success(),
          ]));
      expect(
          surveyStream,
          emitsInOrder([
            surveyUiModel,
            SurveyUiModel.fromSurveyDetail(
              surveyUiModel,
              surveyDetail,
            ),
          ]));

      container
          .read(surveyDetailViewModelProvider.notifier)
          .loadSurveyDetail(surveyUiModel);
    });

    test(
        'When calling load survey detail with negative result, it returns Failed state accordingly',
        () {
      final surveyUiModel = SurveyUiModelMocks.mock();
      final mockException = MockUseCaseException();
      when(mockException.actualException)
          .thenReturn(NetworkExceptions.internalServerError());
      when(mockGetSurveyDetailUseCase.call(any))
          .thenAnswer((_) async => Failed(mockException));
      final stateStream =
          container.read(surveyDetailViewModelProvider.notifier).stream;
      final surveyStream =
          container.read(surveyDetailViewModelProvider.notifier).surveyStream;

      expect(
          stateStream,
          emitsInOrder([
            SurveyDetailState.loading(),
            SurveyDetailState.success(),
            SurveyDetailState.loading(),
            SurveyDetailState.error(
              NetworkExceptions.getErrorMessage(
                  NetworkExceptions.internalServerError()),
            )
          ]));
      expect(
          surveyStream,
          emitsInOrder([
            surveyUiModel,
          ]));

      container
          .read(surveyDetailViewModelProvider.notifier)
          .loadSurveyDetail(surveyUiModel);
    });
  });
}
