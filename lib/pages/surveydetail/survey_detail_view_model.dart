import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/api/request/submit_survey_request.dart';
import 'package:flutter_survey/models/answer.dart';
import 'package:flutter_survey/models/survey_detail.dart';
import 'package:flutter_survey/pages/surveydetail/survey_detail_state.dart';
import 'package:flutter_survey/pages/uimodel/survey_ui_model.dart';
import 'package:flutter_survey/usecase/base/base_use_case.dart';
import 'package:flutter_survey/usecase/get_survey_detail_use_case.dart';
import 'package:flutter_survey/usecase/submit_survey_use_case.dart';
import 'package:rxdart/subjects.dart';

class SurveyDetailViewModel extends StateNotifier<SurveyDetailState> {
  final GetSurveyDetailUseCase _getSurveyDetailUseCase;
  final SubmitSurveyUseCase _submitSurveyUseCase;

  SurveyDetailViewModel(
    this._getSurveyDetailUseCase,
    this._submitSurveyUseCase,
  ) : super(const SurveyDetailState.init());

  final BehaviorSubject<SurveyUiModel> _surveySubject = BehaviorSubject();

  Stream<SurveyUiModel> get surveyStream => _surveySubject.stream;

  final List<SubmitQuestion> _submitQuestions = [];

  Future<void> loadSurveyDetail(SurveyUiModel survey) async {
    // Load initial survey
    _surveySubject.add(survey);
    state = const SurveyDetailState.success();

    // Fetch latest survey detail
    state = const SurveyDetailState.loading();
    final result = await _getSurveyDetailUseCase.call(GetSurveyDetailInput(
      surveyId: survey.id,
    ));
    if (result is Success<SurveyDetail>) {
      final surveyDetail = result.value;
      _surveySubject.add(SurveyUiModel.fromSurveyDetail(survey, surveyDetail));
      state = const SurveyDetailState.success();
    } else {
      _handleError(result as Failed);
    }
  }

  void saveDropdownAnswers(String questionId, Answer answer) {
    _saveAnswersToQuestions(questionId, [SubmitAnswer.fromAnswer(answer)]);
  }

  void saveRatingAnswers(String questionId, int rating) {
    final answers = _getAnswersByQuestionId(questionId);
    final selectedAnswer = answers
        ?.firstWhereOrNull((element) => element.displayOrder == rating - 1);

    final submitAnswers = selectedAnswer != null
        ? [SubmitAnswer.fromAnswer(selectedAnswer)]
        : <SubmitAnswer>[];

    _saveAnswersToQuestions(questionId, submitAnswers);
  }

  void saveMultiSelectionAnswers(
    String questionId,
    List<SubmitAnswer> submitAnswers,
  ) {
    _saveAnswersToQuestions(questionId, submitAnswers);
  }

  void saveTextAreaAnswers(String questionId, String text) {
    final answers = _getAnswersByQuestionId(questionId);
    if (answers == null || answers.isEmpty) return;

    final submitAnswers = text.isNotEmpty
        ? [SubmitAnswer(id: answers.first.id, answer: text)]
        : <SubmitAnswer>[];
    _saveAnswersToQuestions(questionId, submitAnswers);
  }

  void saveTextFieldAnswers(String questionId, String answerId, String text) {
    final submitQuestion = _submitQuestions
        .firstWhereOrNull((element) => element.id == questionId);
    final submitAnswer = submitQuestion?.answers
        .firstWhereOrNull((element) => element.id == answerId);

    if (text.isNotEmpty) {
      final newSubmitAnswer = SubmitAnswer(id: answerId, answer: text);
      if (submitQuestion == null) {
        _submitQuestions
            .add(SubmitQuestion(id: questionId, answers: [newSubmitAnswer]));
      } else if (submitAnswer == null) {
        submitQuestion.answers.add(newSubmitAnswer);
      } else {
        submitAnswer.answer = text;
      }
    } else if (submitQuestion != null && submitAnswer != null) {
      submitQuestion.answers.removeWhere((element) => element.id == answerId);
    }
  }

  Future<void> submitSurvey() async {
    state = const SurveyDetailState.loading();
    final result = await _submitSurveyUseCase.call(
      SubmitSurveyInput(
        surveyId: _surveySubject.value.id,
        questions: _submitQuestions,
      ),
    );
    if (result is Success<void>) {
      state = const SurveyDetailState.submitted();
    } else {
      _handleError(result as Failed);
    }
  }

  _handleError(Failed result) {
    state = SurveyDetailState.error(result.getErrorMessage());
  }

  @override
  void dispose() async {
    await _surveySubject.close();
    super.dispose();
  }

  void _saveAnswersToQuestions(String questionId, List<SubmitAnswer> answers) {
    final question = _submitQuestions
        .firstWhereOrNull((element) => element.id == questionId);

    if (question == null) {
      _submitQuestions.add(SubmitQuestion(
        id: questionId,
        answers: answers,
      ));
    } else {
      question.answers.clear();
      question.answers.addAll(answers);
    }
  }

  List<Answer>? _getAnswersByQuestionId(String questionId) {
    return _surveySubject.value.questions
        .firstWhereOrNull((element) => element.id == questionId)
        ?.answers;
  }
}
