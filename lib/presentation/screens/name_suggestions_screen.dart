import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/app_usage/app_usage_bloc.dart';
import '../../application/application.dart';
import '../../application/app_style/app_style_bloc.dart';
import '../../domain/domain.dart';
import '../../utils/constants/data.dart';
import '../../utils/helpers/dialogs.dart';
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
            icon: BlocSelector<AppStyleBloc, AppStyleState, MaterialColor>(
              selector: (state) => state.appColor,
              builder: (context, appColor) {
                return const Icon(
                  Icons.favorite,
                  color: Colors.pink,
                );
              },
            ),
          )
        ],
      ),
      body: BlocConsumer<NameSuggestionsBloc, NameSuggestionsState>(
        listener: (context, state) {
          if (state.isLoading && state.suggestions.isEmpty) {
            AppDialogs.showParentingTipDialog(context);
            Future.delayed(const Duration(seconds: 10), () {
              if (context.mounted) {
                AppDialogs.closeParentingTipDialog(context);
              }
            });
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.suggestions.isEmpty) {
            return Center(
              child: BlocSelector<AppStyleBloc, AppStyleState, MaterialColor>(
                selector: (state) => state.appColor,
                builder: (context, appColor) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          appColor.shade200,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "${tr('loading', context: context)}...",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }

          if (state.error != null && state.error != "try_later") {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocSelector<AppStyleBloc, AppStyleState, MaterialColor>(
                    selector: (state) => state.appColor,
                    builder: (context, appColor) {
                      return Icon(
                        Icons.error_outline,
                        size: 48,
                        color: appColor.shade200,
                      );
                    },
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
                  BlocSelector<AppStyleBloc, AppStyleState, MaterialColor>(
                    selector: (state) => state.appColor,
                    builder: (context, appColor) {
                      return ElevatedButton(
                        onPressed: () {
                          context.read<NameSuggestionsBloc>().add(
                              NameSuggestionsEvent.generateNames(
                                  state.currentPreference!));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appColor.shade200,
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
                      );
                    },
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
              BlocSelector<AppStyleBloc, AppStyleState, MaterialColor>(
                selector: (state) => state.appColor,
                builder: (context, appColor) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    margin: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 16),
                    decoration: BoxDecoration(
                      color: appColor[50],
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
                  );
                },
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
                                final appUsageBloc =
                                    context.read<AppUsageBloc>();
                                final appUsage = appUsageBloc.state.appUsage;

                                if (appUsage == null ||
                                    appUsage.count <
                                        AppConstants.firstTimeUsageCount) {
                                  appUsageBloc.add(IncrementAppUsageEvent());

                                  final currentPreference =
                                      state.currentPreference!.copyWith(
                                          excludeNames: state.suggestions
                                              .map((s) => s.name.get('en'))
                                              .toList());

                                  context.read<NameSuggestionsBloc>().add(
                                        NameSuggestionsEvent.generateMoreNames(
                                          currentPreference,
                                        ),
                                      );
                                } else {
                                  AppDialogs.showDailyLimitDialog(context);
                                }
                              }
                            },
                            child: BlocSelector<AppStyleBloc, AppStyleState,
                                MaterialColor>(
                              selector: (state) => state.appColor,
                              builder: (context, appColor) {
                                return Text(
                                  (state.error != null
                                          ? "try_later"
                                          : "generate_more")
                                      .tr(context: context),
                                  style: TextStyle(
                                    color: appColor,
                                    fontSize: 16,
                                  ),
                                );
                              },
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
            child: BlocSelector<AppStyleBloc, AppStyleState, MaterialColor>(
              selector: (state) => state.appColor,
              builder: (context, appColor) {
                return FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (ctx) {
                      return const QuestionnaireScreen();
                    }));
                  },
                  backgroundColor: appColor.shade200,
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
                );
              },
            ),
          );
        },
      ),
    );
  }
}
