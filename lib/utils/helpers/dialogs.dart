import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/app_style/app_style_bloc.dart';
import '../../application/app_usage/app_usage_bloc.dart';
import '../../presentation/widgets/running_loading.dart';

class AppDialogs {
  static bool _isParentingTipDialogShown = false;

  static void showParentingTipDialog(BuildContext context) {
    if (_isParentingTipDialogShown) return;
    _isParentingTipDialogShown = true;

    String getRandomTip(BuildContext context) {
      final random = Random();
      final currentTipIndex = random.nextInt(20);
      final tip = tr("tips.$currentTipIndex");
      return tip;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: BlocSelector<AppStyleBloc, AppStyleState, MaterialColor>(
          selector: (state) => state.appColor,
          builder: (context, appColor) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: appColor.shade300,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'did_you_know'.tr(context: context),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: appColor.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  getRandomTip(context),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 26),
                const RunningLoading(),
              ],
            );
          },
        ),
      ),
    );
  }

  static void closeParentingTipDialog(BuildContext context) {
    _isParentingTipDialogShown = false;
    Navigator.of(context, rootNavigator: true).pop();
  }

  static void showDailyLimitDialog(BuildContext context) {
    final lastUsageDate = context.read<AppUsageBloc>().state.appUsage?.date;
    final nextUsageDate = lastUsageDate?.add(const Duration(days: 1));

    // Get current locale for date formatting
    final currentLocale = context.locale.toString();

    // Create date formatters based on locale
    final dateFormatter = DateFormat.yMMMd(currentLocale);
    final timeFormatter = DateFormat.Hm(currentLocale);

    String formatNextUsageDate(DateTime? date) {
      if (date == null) return '';

      final now = DateTime.now();
      final tomorrow = DateTime.now().add(const Duration(days: 1));

      // Check if the date is today or tomorrow
      if (date.year == now.year &&
          date.month == now.month &&
          date.day == now.day) {
        return 'available_today_at'
            .tr(namedArgs: {'time': timeFormatter.format(date)});
      } else if (date.year == tomorrow.year &&
          date.month == tomorrow.month &&
          date.day == tomorrow.day) {
        return 'available_tomorrow_at'
            .tr(namedArgs: {'time': timeFormatter.format(date)});
      } else {
        return 'available_on_date_at'.tr(namedArgs: {
          'date': dateFormatter.format(date),
          'time': timeFormatter.format(date)
        });
      }
    }

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (ctx) {
        return BlocSelector<AppStyleBloc, AppStyleState, MaterialColor>(
          selector: (state) => state.appColor,
          builder: (context, appColor) {
            return Dialog(
              elevation: 8,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: appColor.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: appColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.access_time_rounded,
                        size: 48,
                        color: appColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      context.tr('daily_limit_reached'),
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: appColor,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      context.tr('daily_limit_reached_message'),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black87,
                            height: 1.5,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    if (nextUsageDate != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        formatNextUsageDate(nextUsageDate),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: FilledButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          style: FilledButton.styleFrom(
                            backgroundColor: appColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 32,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            context.tr('daily_limit_reached_button'),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
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
