part of 'questionnaire_bloc.dart';

class QuestionnaireState extends Equatable {
  final int currentQuestionIndex;
  final NamePreference? currentPreference;
  final List<Question> questions;

  const QuestionnaireState({
    required this.currentQuestionIndex,
    required this.currentPreference,
    required this.questions,
  });

  QuestionnaireState copyWith({
    int? currentQuestionIndex,
    NamePreference? currentPreference,
    List<Question>? questions,
    String? error,
  }) {
    return QuestionnaireState(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      currentPreference: currentPreference ?? this.currentPreference,
      questions: questions ?? this.questions,
    );
  }

  factory QuestionnaireState.initial() => const QuestionnaireState(
        currentQuestionIndex: 0,
        currentPreference: null,
        questions: AppConstants.questions,
      );

  @override
  List<Object?> get props {
    return [
      currentQuestionIndex,
      currentPreference,
      questions,
    ];
  }
}
