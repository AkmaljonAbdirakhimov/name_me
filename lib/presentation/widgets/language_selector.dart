import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/app_style/app_style_bloc.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      color: Colors.white,
      icon: BlocSelector<AppStyleBloc, AppStyleState, MaterialColor>(
        selector: (state) => state.appColor,
        builder: (context, appColor) {
          return Icon(
            Icons.language,
            color: appColor.shade300,
          );
        },
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      offset: const Offset(0, 40),
      onSelected: (Locale locale) {
        context.setLocale(locale);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: const Locale('uz'),
          child: _buildLanguageItem('O\'zbek', 'uz'),
        ),
        PopupMenuItem(
          value: const Locale('ru'),
          child: _buildLanguageItem('Русский', 'ru'),
        ),
        PopupMenuItem(
          value: const Locale('en'),
          child: _buildLanguageItem('English', 'en'),
        ),
      ],
    );
  }

  Widget _buildLanguageItem(String title, String code) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.pink[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            code.toUpperCase(),
            style: TextStyle(
              color: Colors.pink[300],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
