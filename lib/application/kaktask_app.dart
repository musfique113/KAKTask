import 'package:flutter/material.dart';
import 'package:kaktask/views/splash_screen.dart';

class KakTaskApp extends StatelessWidget {
  const KakTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData.dark(),
      home: const SplashScreen(),
    );
  }
}
