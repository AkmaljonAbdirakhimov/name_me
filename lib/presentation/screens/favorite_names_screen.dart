import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/application.dart';
import '../presentation.dart';
import '../widgets/app_title.dart';
import '../widgets/language_selector.dart';
import '../widgets/name_suggestion_card.dart';

class FavoriteNamesScreen extends StatelessWidget {
  const FavoriteNamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTitle(
          title: 'favorite_names'.tr(context: context),
        ),
        actions: const [
          LanguageSelector(),
        ],
      ),
      body: BlocBuilder<NameSuggestionsBloc, NameSuggestionsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.pink.shade200),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    tr('loading', context: context),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.pink.shade200,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    tr('error_generating', context: context),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (ctx) {
                        return const QuestionnaireScreen();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade200,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      tr('try_again', context: context),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          final suggestions = state.favoriteSuggestions;

          if (suggestions.isEmpty) {
            return Center(
              child: Text(
                tr('no_favorite_names', context: context),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                margin:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'favorite_names'.tr(context: context),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    return NameSuggestionCard(
                      suggestion: suggestions[index],
                      animate: true,
                      showSaveButton: true,
                      isFavorite: true,
                      onRemove: () async {
                        context.read<NameSuggestionsBloc>().add(
                            NameSuggestionsEvent.removeFavoriteName(index));
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
