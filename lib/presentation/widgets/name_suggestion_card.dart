import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/app_style/app_style_bloc.dart';
import '../../domain/domain.dart';
import 'info_row.dart';

class NameSuggestionCard extends StatelessWidget {
  final NameSuggestion suggestion;
  final bool animate;
  final bool showSaveButton;
  final VoidCallback? onSave;
  final VoidCallback? onRemove;
  final bool isFavorite;

  const NameSuggestionCard({
    super.key,
    required this.suggestion,
    this.animate = false,
    this.showSaveButton = true,
    this.onSave,
    this.onRemove,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final card = Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(4, 8), // Controls the position of the shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    suggestion.name.get(lang),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                BlocSelector<AppStyleBloc, AppStyleState, MaterialColor>(
                  selector: (state) => state.appColor,
                  builder: (context, appColor) {
                    return Row(
                      children: [
                        if (suggestion.popularityScore != null)
                          Tooltip(
                            message: 'popularity_tooltip'.tr(context: context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: appColor.shade50,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: appColor.shade200,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.trending_up,
                                    size: 16,
                                    color: appColor.shade400,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${suggestion.popularityScore?.round() ?? 0}%',
                                    style: TextStyle(
                                      color: appColor.shade400,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (showSaveButton) ...[
                          const SizedBox(width: 8),
                          IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: appColor,
                            ),
                            onPressed: isFavorite ? onRemove : onSave,
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            InfoRow(
              label: 'origin_label'.tr(context: context),
              content: suggestion.origin.get(lang),
              icon: Icons.public,
            ),
            const SizedBox(height: 12),
            InfoRow(
              label: 'meaning_label'.tr(context: context),
              content: suggestion.meaning.get(lang),
              icon: Icons.lightbulb_outline,
            ),
            const SizedBox(height: 12),
            InfoRow(
              label: 'cultural_context_label'.tr(context: context),
              content: suggestion.culturalContext.get(lang),
              icon: Icons.history_edu,
            ),
            if (suggestion.familyConnection.get(lang).isNotEmpty) ...[
              const SizedBox(height: 12),
              InfoRow(
                label: 'family_connection_label'.tr(context: context),
                content: suggestion.familyConnection.get(lang),
                icon: Icons.family_restroom,
              ),
            ],
          ],
        ),
      ),
    );

    if (animate) {
      return AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: 1.0,
        curve: Curves.easeInOut,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          offset: Offset.zero,
          child: card,
        ),
      );
    }

    return card;
  }
}
