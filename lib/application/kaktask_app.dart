import 'package:flutter/material.dart';
import 'package:kaktask/application/services/network_services/network_executor.dart';
import 'package:kaktask/application/theme_data/global_theme_data.dart';
import 'package:kaktask/repositories/task_management_repository.dart';
import 'package:kaktask/view_model/get_created_task_view_model.dart';
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
        ChangeNotifierProvider(create: (_) => ThemeProviderViewModel()),
      ],
      child: Consumer<ThemeProviderViewModel>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'KakTask App',
            home: const SplashScreen(),
            theme: GlobalThemeData.lightTheme,
            darkTheme: GlobalThemeData.darkTheme,
            themeMode: themeProvider.themeMode,
          );
        },
      ),
    );
  }
}
