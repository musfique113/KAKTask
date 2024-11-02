import 'package:flutter/material.dart';
import 'package:kaktask/application/services/network_services/network_executor.dart';
import 'package:kaktask/repositories/task_management_repository.dart';
import 'package:kaktask/view_model/get_created_task_view_model.dart';
import 'package:kaktask/views/splash_screen.dart';
import 'package:provider/provider.dart';

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData.dark(),
        home: const SplashScreen(),
      ),
    );
  }
}
