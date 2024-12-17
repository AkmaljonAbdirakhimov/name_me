import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/app_style/app_style_bloc.dart';
import '../../domain/domain.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppStyleBloc, AppStyleState, MaterialColor>(
      selector: (state) => state.appColor,
      builder: (context, appColor) {
        return Container(
          padding: const EdgeInsets.all(16),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: appColor.shade50,
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
        );
      },
    );
  }
}
