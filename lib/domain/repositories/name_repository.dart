import '../domain.dart';

abstract class NameRepository {
  Future<List<NameSuggestion>> getNameSuggestions(NamePreference preferences);
  Stream<NameSuggestion> streamNameSuggestions(NamePreference preferences);
}
