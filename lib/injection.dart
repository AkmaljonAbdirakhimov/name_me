import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'application/application.dart';
import 'domain/domain.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  await Hive.initFlutter();

  // Services
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(
    () => GenerativeModel(
      model: 'gemini-1.5-pro-latest',
      apiKey: dotenv.env['GEMINI_API_KEY']!,
    ),
  );

  // Register FavoriteNamesService as a singleton
  final favoriteNamesService = FavoriteNamesService();
  await favoriteNamesService.init();
  getIt.registerSingleton(favoriteNamesService);

  final generateNamesService = GenerateNamesService(getIt<GenerativeModel>());
  getIt.registerSingleton(generateNamesService);

  // Repositories
  getIt.registerLazySingleton<NameRepository>(
    () => NameRepositoryImpl(
      generateNamesService: getIt<GenerateNamesService>(),
      favoriteNamesService: getIt<FavoriteNamesService>(),
    ),
  );

  // BLoCs
  getIt.registerFactory(
    () => QuestionnaireBloc(),
  );

  getIt.registerFactory(
    () => NameSuggestionsBloc(getIt<NameRepository>()),
  );
}
