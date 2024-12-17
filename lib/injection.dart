import 'package:dio/dio.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'application/application.dart';
import 'application/app_style/app_style_bloc.dart';
import 'domain/domain.dart';
import 'domain/repositories/app_usage_repository.dart';
import 'domain/repositories/app_usage_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  await Hive.initFlutter();

  final dio = Dio();
  final generativeModel = FirebaseVertexAI.instance.generativeModel(
    model: 'gemini-1.5-flash',
    generationConfig: GenerationConfig(
      responseMimeType: 'application/json',
    ),
  );

  // Services
  getIt.registerLazySingleton(() => dio);
  getIt.registerLazySingleton(
    () => generativeModel,
  );

  // Register FavoriteNamesService as a singleton
  final favoriteNamesService = FavoriteNamesService();
  await favoriteNamesService.init();
  getIt.registerSingleton(favoriteNamesService);

  final appUsageService = AppUsageService();
  await appUsageService.init();
  getIt.registerSingleton(appUsageService);

  final generateNamesService = GenerateNamesService(getIt<GenerativeModel>());
  getIt.registerSingleton(generateNamesService);

  // Repositories
  getIt.registerLazySingleton<NameRepository>(
    () => NameRepositoryImpl(
      generateNamesService: getIt<GenerateNamesService>(),
      favoriteNamesService: getIt<FavoriteNamesService>(),
    ),
  );

  getIt.registerLazySingleton<AppUsageRepository>(
    () => AppUsageRepositoryImpl(
      appUsageService: getIt<AppUsageService>(),
    ),
  );

  // BLoCs
  getIt.registerSingleton(AppStyleBloc());

  getIt.registerFactory(
    () => QuestionnaireBloc(),
  );

  getIt.registerFactory(
    () => NameSuggestionsBloc(getIt<NameRepository>()),
  );
}
