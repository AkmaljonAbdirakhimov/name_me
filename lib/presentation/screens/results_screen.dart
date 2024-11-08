import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:name_me/presentation/widgets/name_suggestion_card.dart';

import '../../application/application.dart';
import '../../domain/domain.dart';
import '../widgets/generating_card.dart';

class ResultsScreen extends StatelessWidget {
  final List<NameSuggestion> suggestions;
  final bool isGenerating;

  const ResultsScreen({
    super.key,
    required this.suggestions,
    required this.isGenerating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                'suggested_names'.tr(context: context),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 80),
              itemCount: suggestions.length + (isGenerating ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == suggestions.length && isGenerating) {
                  return const GeneratingCard();
                }
                return NameSuggestionCard(
                  suggestion: suggestions[index],
                  animate: true,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context
            .read<QuestionnaireBloc>()
            .add(const QuestionnaireEvent.reset()),
        backgroundColor: Colors.pink.shade200,
        foregroundColor: Colors.white,
        elevation: 1,
        icon: const Icon(Icons.refresh_rounded),
        label: Text(
          'start_over'.tr(context: context),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
