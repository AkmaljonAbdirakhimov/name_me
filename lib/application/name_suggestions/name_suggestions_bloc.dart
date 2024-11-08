import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';

part 'name_suggestions_event.dart';
part 'name_suggestions_state.dart';

class NameSuggestionsBloc
    extends Bloc<NameSuggestionsEvent, NameSuggestionsState> {
  final NameRepository _nameRepository;

  NameSuggestionsBloc(this._nameRepository)
      : super(NameSuggestionsState.initial()) {
    on<_GenerateNames>(_onGenerateNames);
    on<_LikeName>(_onLikeName);
    on<_LoadFavoriteNames>(_onLoadFavoriteNames);
    on<_RemoveFavoriteName>(_onRemoveFavoriteName);
  }

  Future<void> _onGenerateNames(
    _GenerateNames event,
    Emitter<NameSuggestionsState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      isGenerating: true,
      suggestions: [],
      error: null,
    ));

    try {
      await emit.onEach(
          _nameRepository.streamNameSuggestions(event.currentPreference),
          onData: (suggestion) {
        emit(state.copyWith(
          suggestions: [...state.suggestions, suggestion],
          isLoading: false,
          isGenerating: true,
        ));
      }, onError: (error, stack) {
        emit(state.copyWith(
          error: error.toString(),
          isLoading: false,
          isGenerating: false,
        ));
      });

      emit(state.copyWith(
        isGenerating: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
        isGenerating: false,
      ));
    }
  }

  Future<void> _onLikeName(
    _LikeName event,
    Emitter<NameSuggestionsState> emit,
  ) async {
    try {
      await _nameRepository.likeName(event.suggestion);
      final favoriteSuggestions = _nameRepository.getFavoriteNames();
      final suggestions = state.suggestions.map((s) {
        if (s == event.suggestion) {
          return s.copyWith(isFavorite: !event.suggestion.isFavorite);
        }
        return s;
      }).toList();
      emit(state.copyWith(
        suggestions: suggestions,
        favoriteSuggestions: favoriteSuggestions,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void _onLoadFavoriteNames(
      _LoadFavoriteNames event, Emitter<NameSuggestionsState> emit) {
    try {
      final favoriteSuggestions = _nameRepository.getFavoriteNames();
      emit(state.copyWith(favoriteSuggestions: favoriteSuggestions));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onRemoveFavoriteName(
    _RemoveFavoriteName event,
    Emitter<NameSuggestionsState> emit,
  ) async {
    try {
      await _nameRepository.removeFavoriteName(event.index);
      final favoriteSuggestions = _nameRepository.getFavoriteNames();
      final suggestions = state.suggestions.map((s) {
        final isContained = favoriteSuggestions.contains(s);
        return s.copyWith(isFavorite: isContained);
      }).toList();
      emit(state.copyWith(
        suggestions: suggestions,
        favoriteSuggestions: favoriteSuggestions,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
