import 'package:flutter/material.dart';

import '../../domain/domain.dart';
import 'multiple_choice_options.dart';
import 'progress_bar.dart';
import 'question_card.dart';
import 'text_input_question.dart';

class QuestionView extends StatelessWidget {
  final Question question;
  final double progress;

  const QuestionView({
    super.key,
    required this.question,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProgressBar(progress: progress),
          const SizedBox(height: 20),
          QuestionCard(question: question),
          const SizedBox(height: 20),
          Expanded(
            child:
                question.type == 'father_name' || question.type == 'mother_name'
                    ? TextInputQuestion(
                        question: question,
                        progress: progress,
                      )
                    : MultipleChoiceOptions(question: question),
          ),
        ],
      ),
    );
  }
}
