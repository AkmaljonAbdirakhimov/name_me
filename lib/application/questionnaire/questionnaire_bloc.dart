import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';
import '../../utils/utils.dart';

part 'questionnaire_event.dart';
part 'questionnaire_state.dart';

class QuestionnaireBloc extends Bloc<QuestionnaireEvent, QuestionnaireState> {
  final NameRepository _nameRepository;
  final Map<String, String> _answers = {};

  QuestionnaireBloc(this._nameRepository)
      : super(QuestionnaireState.initial()) {
    on<_AnswerSelected>(_onAnswerSelected);
    on<_GenerateNames>(_onGenerateNames);
    on<_Reset>(_onReset);
  }

  Future<void> _onAnswerSelected(
    _AnswerSelected event,
    Emitter<QuestionnaireState> emit,
  ) async {
    try {
      final questionType = state.questions[state.currentQuestionIndex].type;
      _answers[questionType] = event.answer;

      if (state.currentQuestionIndex < state.questions.length - 1) {
        emit(state.copyWith(
          currentQuestionIndex: state.currentQuestionIndex + 1,
        ));
      } else {
        final preferences = NamePreference.fromMap(_answers);
        emit(state.copyWith(currentPreference: preferences));
        add(const QuestionnaireEvent.generateNames());
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _onGenerateNames(
    _GenerateNames event,
    Emitter<QuestionnaireState> emit,
  ) async {
    if (state.currentPreference == null) return;

    emit(state.copyWith(
      isLoading: true,
      isGenerating: true,
      suggestions: [],
      error: null,
    ));

    try {
      await emit.onEach(
          _nameRepository.streamNameSuggestions(state.currentPreference!),
          onData: (suggestion) {
        log(suggestion.toString());
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

  void _onReset(_Reset event, Emitter<QuestionnaireState> emit) {
    _answers.clear();
    emit(QuestionnaireState.initial());
  }
}
