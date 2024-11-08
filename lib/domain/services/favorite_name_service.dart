import 'package:hive_flutter/hive_flutter.dart';

import '../domain.dart';
import '../models/favorite_name_suggestion.dart';

class FavoriteNamesService {
  static const String _boxName = 'favorite_names';
  late Box<FavoriteNameSuggestion> _box;

  Future<void> init() async {
    Hive.registerAdapter(FavoriteNameSuggestionAdapter());
    _box = await Hive.openBox<FavoriteNameSuggestion>(_boxName);
  }

  Future<void> likeName(NameSuggestion suggestion) async {
    final favoriteSuggestion = FavoriteNameSuggestion.fromNameSuggestion(suggestion);
    await _box.add(favoriteSuggestion);
  }

  Future<void> removeName(int index) async {
    await _box.deleteAt(index);
  }

  List<NameSuggestion> getAllFavoriteNames() {
    return _box.values.map((favorite) => favorite.toNameSuggestion()).toList();
  }

  bool isNameFavorite(NameSuggestion suggestion) {
    return _box.values.any((favorite) =>
        favorite.name[suggestion.name.values.keys.first] ==
        suggestion.name.values[suggestion.name.values.keys.first]);
  }
}
