part of 'name_suggestions_bloc.dart';

class NameSuggestionsState extends Equatable {
  final List<NameSuggestion> suggestions;
  final List<NameSuggestion> favoriteSuggestions;
  final bool isLoading;
  final bool isGenerating;
  final String? error;

  const NameSuggestionsState({
    required this.suggestions,
    required this.favoriteSuggestions,
    required this.isLoading,
    required this.isGenerating,
    this.error,
  });

  NameSuggestionsState copyWith({
    List<NameSuggestion>? suggestions,
    List<NameSuggestion>? favoriteSuggestions,
    bool? isLoading,
    bool? isGenerating,
    String? error,
  }) {
    return NameSuggestionsState(
      suggestions: suggestions ?? this.suggestions,
      favoriteSuggestions: favoriteSuggestions ?? this.favoriteSuggestions,
      isLoading: isLoading ?? this.isLoading,
      isGenerating: isGenerating ?? this.isGenerating,
      error: error,
    );
  }

  factory NameSuggestionsState.initial() => const NameSuggestionsState(
        suggestions: [],
        favoriteSuggestions: [],
        isLoading: false,
        isGenerating: false,
      );

  @override
  List<Object?> get props => [
        suggestions,
        favoriteSuggestions,
        isLoading,
        isGenerating,
        error,
      ];
}
