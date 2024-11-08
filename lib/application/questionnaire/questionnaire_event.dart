part of 'questionnaire_bloc.dart';

sealed class QuestionnaireEvent {
  const factory QuestionnaireEvent.answerSelected(String answer) =
      _AnswerSelected;
  const factory QuestionnaireEvent.generateNames() = _GenerateNames;
  const factory QuestionnaireEvent.reset() = _Reset;
}

class _AnswerSelected implements QuestionnaireEvent {
  final String answer;
  const _AnswerSelected(this.answer);
}

class _GenerateNames implements QuestionnaireEvent {
  const _GenerateNames();
}

class _Reset implements QuestionnaireEvent {
  const _Reset();
}
