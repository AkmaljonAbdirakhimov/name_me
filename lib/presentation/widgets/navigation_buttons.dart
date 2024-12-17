import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/application.dart';
import '../../application/app_style/app_style_bloc.dart';

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionnaireBloc, QuestionnaireState>(
      builder: (context, state) {
        final isFirstQuestion = state.currentQuestionIndex == 0;
        final isLastQuestion =
            state.currentQuestionIndex == state.questions.length - 1;
        final hasAnswer = state.currentAnswer?.isNotEmpty == true;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Previous Button
              if (!isFirstQuestion)
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context
                        .read<QuestionnaireBloc>()
                        .add(const QuestionnaireEvent.previousQuestion()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.all(16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'previous'.tr(context: context),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

              if (!isFirstQuestion) const SizedBox(width: 16),

              // Next/Finish Button
              Expanded(
                child: BlocSelector<AppStyleBloc, AppStyleState, MaterialColor>(
                  selector: (state) => state.appColor,
                  builder: (context, appColor) {
                    return ElevatedButton(
                      onPressed: hasAnswer
                          ? () => context
                              .read<QuestionnaireBloc>()
                              .add(const QuestionnaireEvent.nextQuestion())
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColor.shade200,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isLastQuestion
                            ? 'generate'.tr(context: context)
                            : 'next'.tr(context: context),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
