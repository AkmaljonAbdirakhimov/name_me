import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/application.dart';
import '../../application/app_style/app_style_bloc.dart';
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
            child: BlocSelector<AppStyleBloc, AppStyleState, MaterialColor>(
              selector: (state) => state.appColor,
              builder: (context, appColor) {
                return TextFormField(
                  controller: _controller,
                  cursorColor: appColor.shade200,
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
                      borderSide: BorderSide(color: appColor.shade200),
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
                );
              },
            ),
          );
        },
      ),
    );
  }
}
