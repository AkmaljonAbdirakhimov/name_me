import '../domain.dart';

abstract class NameRepository {
  Stream<NameSuggestion> streamNameSuggestions(NamePreference preferences);
  Future<void> likeName(NameSuggestion suggestion);
  Future<void> removeFavoriteName(int index);
  List<NameSuggestion> getFavoriteNames();
  bool isNameFavorite(NameSuggestion suggestion);
}
