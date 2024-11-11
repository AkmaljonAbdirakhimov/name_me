import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/application.dart';
import '../../domain/domain.dart';

class MultipleChoiceOptions extends StatelessWidget {
  const MultipleChoiceOptions({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionnaireBloc, QuestionnaireState>(
      builder: (context, state) {
        final selectedAnswers = state.answers[question.type] ?? [];

        print(selectedAnswers);

        return ListView.builder(
          itemCount: question.options.length,
          itemBuilder: (context, index) {
            final option = question.options[index];
            final isSelected = selectedAnswers.contains(option);

            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: () => context
                    .read<QuestionnaireBloc>()
                    .add(QuestionnaireEvent.answerSelected(option)),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isSelected ? Colors.pink.shade50 : Colors.white,
                  foregroundColor: isSelected ? Colors.pink : Colors.black87,
                  overlayColor: Colors.pink,
                  padding: const EdgeInsets.all(20),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        question.type == 'country'
                            ? 'countries.$option'.tr(context: context)
                            : option.tr(context: context),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: Colors.pink),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
