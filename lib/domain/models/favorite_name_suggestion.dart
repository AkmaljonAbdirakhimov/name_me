import 'package:hive/hive.dart';

import '../../utils/utils.dart';
import 'name_suggestion.dart';

part 'favorite_name_suggestion.g.dart';

@HiveType(typeId: 1)
class FavoriteNameSuggestion extends HiveObject {
  @HiveField(0)
  final Map<String, String> name;

  @HiveField(1)
  final Map<String, String> meaning;

  @HiveField(2)
  final Map<String, String> origin;

  @HiveField(3)
  final Map<String, String> culturalContext;

  @HiveField(4)
  final Map<String, String> familyConnection;

  @HiveField(5)
  final int? popularityScore;

  FavoriteNameSuggestion({
    required this.name,
    required this.meaning,
    required this.origin,
    required this.culturalContext,
    required this.familyConnection,
    this.popularityScore,
  });

  factory FavoriteNameSuggestion.fromNameSuggestion(NameSuggestion suggestion) {
    return FavoriteNameSuggestion(
      name: suggestion.name.values,
      meaning: suggestion.meaning.values,
      origin: suggestion.origin.values,
      culturalContext: suggestion.culturalContext.values,
      familyConnection: suggestion.familyConnection.values,
      popularityScore: suggestion.popularityScore,
    );
  }

  NameSuggestion toNameSuggestion() {
    return NameSuggestion(
      name: LocalizedString.fromMap(name),
      meaning: LocalizedString.fromMap(meaning),
      origin: LocalizedString.fromMap(origin),
      culturalContext: LocalizedString.fromMap(culturalContext),
      familyConnection: LocalizedString.fromMap(familyConnection),
      popularityScore: popularityScore,
    );
  }
}
