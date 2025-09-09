import 'package:flutter/material.dart';
import 'package:flutter_bloc_cubit/routes/app_routes.dart';
import 'package:flutter_bloc_cubit/scenes/splash_screen/view/splash_screen.dart';
import 'package:flutter_bloc_cubit/theme/app_theme.dart';

import 'constants/app_environments.dart';
import 'l10n/app_localization_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: EnvironmentConfig.isDemo ? true : false,
      onGenerateRoute: AppRoutes.generateRoute,
      supportedLocales: AppLocalizationConfig.supportedLocales,
      localizationsDelegates: AppLocalizationConfig.localizationsDelegates,
      localeResolutionCallback: (locale, supportedLocales) {
        return AppLocalizationConfig.isSupported(locale!)
            ? locale
            : supportedLocales.first;
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
