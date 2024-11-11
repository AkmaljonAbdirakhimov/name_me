import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/application.dart';
import '../../domain/domain.dart';

class TextInputQuestion extends StatefulWidget {
  final Question question;
  final double progress;

  const TextInputQuestion({
    super.key,
    required this.question,
    required this.progress,
  });

  @override
  State<TextInputQuestion> createState() => _TextInputQuestionState();
}

class _TextInputQuestionState extends State<TextInputQuestion> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<QuestionnaireBloc, QuestionnaireState>(
        buildWhen: (previous, current) =>
            previous.currentQuestionIndex != current.currentQuestionIndex,
        builder: (context, state) {
          _controller.text = state.currentAnswer ?? '';
          return Form(
            key: _formKey,
            child: TextFormField(
              controller: _controller,
              cursorColor: Colors.pink.shade200,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.pink.shade200),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.red.shade300),
                ),
              ),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'name_required'.tr(context: context);
                }

                return null;
              },
              onChanged: (value) {
                _formKey.currentState!.validate();
                context
                    .read<QuestionnaireBloc>()
                    .add(QuestionnaireEvent.answerSelected(value.trim()));
              },
            ),
          );
        },
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     if (_formKey.currentState!.validate()) {
      //       context
      //           .read<QuestionnaireBloc>()
      //           .add(QuestionnaireEvent.answerSelected(controller.text.trim()));
      //     }
      //   },
      //   backgroundColor: Colors.pink.shade200,
      //   foregroundColor: Colors.white,
      //   extendedPadding: const EdgeInsets.symmetric(
      //     horizontal: 32,
      //     vertical: 16,
      //   ),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(12),
      //   ),
      //   label: Text(
      //     tr('continue', context: context),
      //     style: const TextStyle(
      //       fontSize: 16,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
    );
  }
}
