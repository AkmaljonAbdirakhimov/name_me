import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/app_style/app_style_bloc.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.progress,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BlocSelector<AppStyleBloc, AppStyleState, MaterialColor>(
        selector: (state) => state.appColor,
        builder: (context, appColor) {
          return LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade100,
            valueColor: AlwaysStoppedAnimation<Color>(appColor.shade200),
            minHeight: 8,
          );
        },
      ),
    );
  }
}
