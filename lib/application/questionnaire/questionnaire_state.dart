part of 'questionnaire_bloc.dart';

class QuestionnaireState extends Equatable {
  final int currentQuestionIndex;
  final NamePreference? currentPreference;
  final List<Question> questions;
  final Map<String, dynamic> answers;
  final String? currentAnswer;

  const QuestionnaireState({
    required this.currentQuestionIndex,
    required this.currentPreference,
    required this.questions,
    required this.answers,
    this.currentAnswer,
  });

  QuestionnaireState copyWith({
    int? currentQuestionIndex,
    NamePreference? currentPreference,
    List<Question>? questions,
    Map<String, dynamic>? answers,
    String? currentAnswer,
  }) {
    return QuestionnaireState(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      currentPreference: currentPreference ?? this.currentPreference,
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
      currentAnswer: currentAnswer,
    );
  }

  factory QuestionnaireState.initial() => const QuestionnaireState(
        currentQuestionIndex: 0,
        currentPreference: null,
        questions: AppConstants.questions,
        answers: {},
        currentAnswer: null,
      );

  @override
  List<Object?> get props {
    return [
      currentQuestionIndex,
      currentPreference,
      questions,
      answers,
      currentAnswer,
    ];
  }
}
