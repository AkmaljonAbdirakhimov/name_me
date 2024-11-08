import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'application/application.dart';
import 'domain/domain.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Services
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(
    () => GenerativeModel(
      model: 'gemini-1.5-pro-latest',
      apiKey: dotenv.env['GEMINI_API_KEY']!,
    ),
  );

  // Repositories
  getIt.registerLazySingleton<NameRepository>(
    () => NameRepositoryImpl(
      getIt<GenerativeModel>(),
    ),
  );

  // BLoCs
  getIt.registerFactory(
    () => QuestionnaireBloc(getIt<NameRepository>()),
  );
}
