import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';
import '../../utils/utils.dart';

part 'questionnaire_event.dart';
part 'questionnaire_state.dart';

class QuestionnaireBloc extends Bloc<QuestionnaireEvent, QuestionnaireState> {
  final Map<String, String> _answers = {};

  QuestionnaireBloc() : super(QuestionnaireState.initial()) {
    on<_AnswerSelected>(_onAnswerSelected);
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
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
