import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final String? title;
  const AppTitle({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        title ?? tr('app_title', context: context),
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
