import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';
import '../../utils/utils.dart';

part 'questionnaire_event.dart';
part 'questionnaire_state.dart';

class QuestionnaireBloc extends Bloc<QuestionnaireEvent, QuestionnaireState> {
  QuestionnaireBloc() : super(QuestionnaireState.initial()) {
    on<_AnswerSelected>(_onAnswerSelected);
    on<_NextQuestion>(_onNextQuestion);
    on<_PreviousQuestion>(_onPreviousQuestion);
  }

  void _onAnswerSelected(
    _AnswerSelected event,
    Emitter<QuestionnaireState> emit,
  ) {
    try {
      final currentQuestion = state.questions[state.currentQuestionIndex];

      final Map<String, dynamic> newAnswers = Map<String, dynamic>.from(
        state.answers.map((key, value) {
          if (value is List) {
            return MapEntry(key, List<String>.from(value));
          }
          return MapEntry(key, value);
        }),
      );

      if (currentQuestion.isMultipleSelect) {
        newAnswers[currentQuestion.type] ??= <String>[];
        if (newAnswers[currentQuestion.type].contains(event.answer)) {
          newAnswers[currentQuestion.type].remove(event.answer);
        } else {
          newAnswers[currentQuestion.type].add(event.answer);
        }
      } else {
        newAnswers[currentQuestion.type] = event.answer;
      }

      emit(state.copyWith(
        answers: newAnswers,
        currentAnswer: event.answer,
      ));
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());
    }
  }

  void _onNextQuestion(
    _NextQuestion event,
    Emitter<QuestionnaireState> emit,
  ) {
    try {
      if (state.currentQuestionIndex < state.questions.length - 1) {
        final nextIndex = state.currentQuestionIndex + 1;
        final nextQuestion = state.questions[nextIndex];

        final savedAnswer = state.answers[nextQuestion.type];

        emit(state.copyWith(
          currentQuestionIndex: nextIndex,
          currentAnswer: savedAnswer,
        ));
      } else {
        final preference = NamePreference.fromMap(state.answers);
        emit(state.copyWith(currentPreference: preference));
      }
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());
    }
  }

  void _onPreviousQuestion(
    _PreviousQuestion event,
    Emitter<QuestionnaireState> emit,
  ) {
    try {
      if (state.currentQuestionIndex > 0) {
        final previousIndex = state.currentQuestionIndex - 1;
        final previousQuestion = state.questions[previousIndex];

        final savedAnswer = state.answers[previousQuestion.type];

        emit(state.copyWith(
          currentQuestionIndex: previousIndex,
          currentAnswer: savedAnswer,
        ));
      }
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());
    }
  }
}
