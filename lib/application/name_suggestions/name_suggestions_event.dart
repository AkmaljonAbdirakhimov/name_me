part of 'name_suggestions_bloc.dart';

sealed class NameSuggestionsEvent {
  const factory NameSuggestionsEvent.generateNames(
      NamePreference currentPreference) = _GenerateNames;
  const factory NameSuggestionsEvent.save(NameSuggestion suggestion) =
      _LikeName;
  const factory NameSuggestionsEvent.loadFavoriteNames() = _LoadFavoriteNames;
  const factory NameSuggestionsEvent.removeFavoriteName(int index) =
      _RemoveFavoriteName;
}

class _GenerateNames implements NameSuggestionsEvent {
  final NamePreference currentPreference;
  const _GenerateNames(this.currentPreference);
}

class _LikeName implements NameSuggestionsEvent {
  final NameSuggestion suggestion;
  const _LikeName(this.suggestion);
}

class _LoadFavoriteNames implements NameSuggestionsEvent {
  const _LoadFavoriteNames();
}

class _RemoveFavoriteName implements NameSuggestionsEvent {
  final int index;
  const _RemoveFavoriteName(this.index);
}
