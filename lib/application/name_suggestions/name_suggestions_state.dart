part of 'name_suggestions_bloc.dart';

class NameSuggestionsState extends Equatable {
  final NamePreference? currentPreference;
  final List<NameSuggestion> suggestions;
  final List<NameSuggestion> favoriteSuggestions;
  final bool isLoading;
  final bool isGenerating;
  final String? error;

  const NameSuggestionsState({
    this.currentPreference,
    required this.suggestions,
    required this.favoriteSuggestions,
    required this.isLoading,
    required this.isGenerating,
    this.error,
  });

  NameSuggestionsState copyWith({
    NamePreference? currentPreference,
    List<NameSuggestion>? suggestions,
    List<NameSuggestion>? favoriteSuggestions,
    bool? isLoading,
    bool? isGenerating,
    String? error,
  }) {
    return NameSuggestionsState(
      currentPreference: currentPreference ?? this.currentPreference,
      suggestions: suggestions ?? this.suggestions,
      favoriteSuggestions: favoriteSuggestions ?? this.favoriteSuggestions,
      isLoading: isLoading ?? this.isLoading,
      isGenerating: isGenerating ?? this.isGenerating,
      error: error ?? this.error,
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
        currentPreference,
        suggestions,
        favoriteSuggestions,
        isLoading,
        isGenerating,
        error,
      ];
}
