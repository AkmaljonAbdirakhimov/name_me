import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../domain/domain.dart';
import 'multiple_choice_options.dart';
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
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade100,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.pink.shade200),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              question.text.tr(context: context),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
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
