import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/app_style/app_style_bloc.dart';
import '../../application/app_usage/app_usage_bloc.dart';

class AppDialogs {
  static void showDailyLimitDialog(BuildContext context) {
    final lastUsageDate = context.read<AppUsageBloc>().state.appUsage?.date;
    final nextUsageDate = lastUsageDate?.add(const Duration(days: 1));

    print(nextUsageDate);
    showDialog(
      context: context,
      builder: (ctx) {
        return BlocSelector<AppStyleBloc, AppStyleState, MaterialColor>(
          selector: (state) => state.appColor,
          builder: (context, appColor) {
            return AlertDialog(
              title: Text(
                context.tr('daily_limit_reached'),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: appColor,
                    ),
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time,
                    size: 48,
                    color: appColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.tr('daily_limit_reached_message'),
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(
                    context.tr('daily_limit_reached_button'),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
