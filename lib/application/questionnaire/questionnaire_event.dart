part of 'questionnaire_bloc.dart';

sealed class QuestionnaireEvent {
  const factory QuestionnaireEvent.answerSelected(String answer) =
      _AnswerSelected;
}

class _AnswerSelected implements QuestionnaireEvent {
  final String answer;
  const _AnswerSelected(this.answer);
}
