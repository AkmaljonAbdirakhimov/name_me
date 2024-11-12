import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/application.dart';
import '../../domain/domain.dart';
import '../presentation.dart';
import '../widgets/app_title.dart';
import '../widgets/generating_card.dart';
import '../widgets/language_selector.dart';
import '../widgets/name_suggestion_card.dart';

class NameSuggestionsScreen extends StatelessWidget {
  const NameSuggestionsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LanguageSelector(),
        title: const AppTitle(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                return BlocProvider.value(
                  value: context.read<NameSuggestionsBloc>()
                    ..add(const NameSuggestionsEvent.loadFavoriteNames()),
                  child: const FavoriteNamesScreen(),
                );
              }));
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.pink,
            ),
          )
        ],
      ),
      body: BlocBuilder<NameSuggestionsBloc, NameSuggestionsState>(
        builder: (context, state) {
          if (state.isLoading && state.suggestions.isEmpty) {
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
                      context.read<NameSuggestionsBloc>().add(
                          NameSuggestionsEvent.generateNames(
                              state.currentPreference!));
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
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          final suggestions = state.suggestions;
          final isGenerating = state.isGenerating;

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
                    'suggested_names'.tr(context: context),
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
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 120),
                  itemCount: suggestions.length + 1,
                  itemBuilder: (context, index) {
                    if (index == suggestions.length && isGenerating) {
                      return const GeneratingCard();
                    }

                    if (index == suggestions.length + (isGenerating ? 1 : 0)) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              if (state.currentPreference != null) {
                                final currentPreference =
                                    state.currentPreference!.copyWith(
                                        excludeNames: state.suggestions
                                            .map((s) => s.name.get('en'))
                                            .toList());

                                context
                                    .read<NameSuggestionsBloc>()
                                    .add(NameSuggestionsEvent.generateMoreNames(
                                      currentPreference,
                                    ));
                              }
                            },
                            child: Text(
                              "generate_more".tr(context: context),
                              style: const TextStyle(
                                color: Colors.pink,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    final suggestion = suggestions[index];
                    return NameSuggestionCard(
                      suggestion: suggestion,
                      animate: true,
                      showSaveButton: true,
                      isFavorite: suggestion.isFavorite,
                      onSave: () {
                        context.read<NameSuggestionsBloc>().add(
                              NameSuggestionsEvent.like(suggestions[index]),
                            );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocSelector<NameSuggestionsBloc,
          NameSuggestionsState, List<NameSuggestion>>(
        selector: (state) => state.suggestions,
        builder: (context, suggestions) {
          return Visibility(
            visible: suggestions.isNotEmpty,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) {
                  return const QuestionnaireScreen();
                }));
              },
              backgroundColor: Colors.pink.shade200,
              foregroundColor: Colors.white,
              elevation: 1,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(
                'start_over'.tr(context: context),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
