import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:name_me/utils/utils.dart';

import '../../application/app_usage/app_usage_bloc.dart';
import '../../application/application.dart';
import '../../utils/helpers/dialogs.dart';
import '../presentation.dart';
import '../widgets/app_title.dart';
import '../widgets/language_selector.dart';
import '../widgets/navigation_buttons.dart';

class QuestionnaireScreen extends StatelessWidget {
  const QuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<QuestionnaireBloc>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            leading: const LanguageSelector(),
            title: const AppTitle(),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                    return BlocProvider(
                      create: (context) => GetIt.I<NameSuggestionsBloc>()
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
          body: BlocConsumer<QuestionnaireBloc, QuestionnaireState>(
            buildWhen: (previous, current) =>
                previous.currentQuestionIndex != current.currentQuestionIndex,
            listener: (context, state) {
              if (state.currentPreference != null) {
                final appUsageBloc = context.read<AppUsageBloc>();
                final appUsage = appUsageBloc.state.appUsage;
                if (appUsage == null ||
                    appUsage.count < AppConstants.firstTimeUsageCount) {
                  appUsageBloc.add(IncrementAppUsageEvent());

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (ctx) {
                    return BlocProvider(
                      create: (context) => GetIt.I<NameSuggestionsBloc>()
                        ..add(NameSuggestionsEvent.generateNames(
                            state.currentPreference!))
                        ..add(const NameSuggestionsEvent.loadFavoriteNames()),
                      child: const NameSuggestionsScreen(),
                    );
                  }));
                } else {
                  AppDialogs.showDailyLimitDialog(context);
                }
              }
            },
            builder: (context, state) {
              return QuestionView(
                question: state.questions[state.currentQuestionIndex],
                progress:
                    (state.currentQuestionIndex + 1) / state.questions.length,
              );
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: const NavigationButtons(),
        );
      }),
    );
  }
}
