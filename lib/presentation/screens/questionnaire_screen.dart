import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/application.dart';
import '../presentation.dart';
import '../widgets/language_selector.dart';

class QuestionnaireScreen extends StatelessWidget {
  const QuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('app_title', context: context),
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          LanguageSelector(),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<QuestionnaireBloc, QuestionnaireState>(
          builder: (context, state) {
            if (state.isLoading && state.suggestions.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.pink.shade200),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      tr('loading', context: context),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.pink.shade200,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      tr('error_generating', context: context),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => context
                          .read<QuestionnaireBloc>()
                          .add(const QuestionnaireEvent.reset()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade200,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        tr('try_again', context: context),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state.suggestions.isNotEmpty) {
              return ResultsScreen(
                suggestions: state.suggestions,
                isGenerating: state.isGenerating,
              );
            }

            return QuestionView(
              question: state.questions[state.currentQuestionIndex],
              progress:
                  (state.currentQuestionIndex + 1) / state.questions.length,
            );
          },
        ),
      ),
    );
  }
}
