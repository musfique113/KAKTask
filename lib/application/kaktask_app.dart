import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kaktask/application/services/network_services/network_executor.dart';
import 'package:kaktask/application/theme_data/global_theme_data.dart';
import 'package:kaktask/repositories/task_management_repository.dart';
import 'package:kaktask/view_model/created_new_task_view_model.dart';
import 'package:kaktask/view_model/get_created_task_view_model.dart';
import 'package:kaktask/view_model/language_provider.dart';
import 'package:kaktask/views/splash_screen.dart';
import 'package:provider/provider.dart';

import '../view_model/theme_provider_view_model.dart';

class KakTaskApp extends StatelessWidget {
  const KakTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GetCreatedTaskViewModel(
            TaskManagementRepository(
              NetworkExecutor(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CreateNewTaskViewModel(
            TaskManagementRepository(
              NetworkExecutor(),
            ),
          ),
        ),
        ChangeNotifierProvider.value(value: ThemeProviderViewModel()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: Consumer<ThemeProviderViewModel>(
        builder: (context, themeProvider, child) {
          return Consumer<LanguageProvider>(
              builder: (context, languageProvider, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'KakTask App',
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: languageProvider.locale,
              supportedLocales: AppLocalizations.supportedLocales,
              home: const SplashScreen(),
              theme: GlobalThemeData.lightTheme,
              darkTheme: GlobalThemeData.darkTheme,
              themeMode: themeProvider.themeMode,
            );
          });
        },
      ),
    );
  }
}
