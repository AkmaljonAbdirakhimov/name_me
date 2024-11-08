part of 'questionnaire_bloc.dart';

class QuestionnaireState extends Equatable {
  final int currentQuestionIndex;
  final NamePreference? currentPreference;
  final List<Question> questions;
  final List<NameSuggestion> suggestions;
  final bool isLoading;
  final bool isGenerating;
  final String? error;

  const QuestionnaireState({
    required this.currentQuestionIndex,
    required this.currentPreference,
    required this.questions,
    required this.suggestions,
    required this.isLoading,
    required this.isGenerating,
    this.error,
  });

  QuestionnaireState copyWith({
    int? currentQuestionIndex,
    NamePreference? currentPreference,
    List<Question>? questions,
    List<NameSuggestion>? suggestions,
    bool? isLoading,
    bool? isGenerating,
    String? error,
  }) {
    return QuestionnaireState(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      currentPreference: currentPreference ?? this.currentPreference,
      questions: questions ?? this.questions,
      suggestions: suggestions ?? this.suggestions,
      isLoading: isLoading ?? this.isLoading,
      isGenerating: isGenerating ?? this.isGenerating,
      error: error ?? this.error,
    );
  }

  factory QuestionnaireState.initial() => const QuestionnaireState(
        currentQuestionIndex: 0,
        currentPreference: null,
        questions: AppConstants.questions,
        suggestions: [],
        isLoading: false,
        isGenerating: false,
      );

  @override
  List<Object?> get props {
    return [
      currentQuestionIndex,
      currentPreference,
      questions,
      suggestions,
      isLoading,
      isGenerating,
      error,
    ];
  }
}
