import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:name_me/firebase_options.dart';
import 'application/app_style/app_style_bloc.dart';
import 'application/app_usage/app_usage_bloc.dart';
import 'injection.dart';
import 'presentation/presentation.dart';
import 'utils/styles/app_themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await setupDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('uz'),
        Locale('ru'),
        Locale('en'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('uz'),
      startLocale: const Locale('uz'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AppStyleBloc>(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => getIt<AppUsageBloc>()..add(GetAppUsageEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Name Baby',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: AppThemes.girlTheme,
        home: const SplashScreen(),
        builder: (context, child) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: child!,
            ),
          );
        },
      ),
    );
  }
}
