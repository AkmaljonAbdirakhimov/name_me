import '../domain.dart';

class NameRepositoryImpl implements NameRepository {
  final GenerateNamesService _generateNamesService;
  final FavoriteNamesService _favoriteNamesService;

  NameRepositoryImpl(
      {required GenerateNamesService generateNamesService,
      required FavoriteNamesService favoriteNamesService})
      : _generateNamesService = generateNamesService,
        _favoriteNamesService = favoriteNamesService;

  @override
  Stream<NameSuggestion> streamNameSuggestions(
    NamePreference preferences,
  ) async* {
    yield* _generateNamesService.streamNameSuggestions(preferences);
  }

  @override
  Future<void> likeName(NameSuggestion suggestion) async {
    await _favoriteNamesService.likeName(suggestion);
  }

  @override
  Future<void> removeFavoriteName(int index) async {
    await _favoriteNamesService.removeName(index);
  }

  @override
  List<NameSuggestion> getFavoriteNames() {
    return _favoriteNamesService.getAllFavoriteNames();
  }

  @override
  bool isNameFavorite(NameSuggestion suggestion) {
    return _favoriteNamesService.isNameFavorite(suggestion);
  }
}
