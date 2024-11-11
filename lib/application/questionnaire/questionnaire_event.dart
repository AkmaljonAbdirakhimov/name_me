part of 'questionnaire_bloc.dart';

sealed class QuestionnaireEvent {
  const factory QuestionnaireEvent.answerSelected(String answer) =
      _AnswerSelected;
  const factory QuestionnaireEvent.nextQuestion() = _NextQuestion;
  const factory QuestionnaireEvent.previousQuestion() = _PreviousQuestion;
}

class _AnswerSelected implements QuestionnaireEvent {
  final String answer;
  const _AnswerSelected(this.answer);
}

class _NextQuestion implements QuestionnaireEvent {
  const _NextQuestion();
}

class _PreviousQuestion implements QuestionnaireEvent {
  const _PreviousQuestion();
}
