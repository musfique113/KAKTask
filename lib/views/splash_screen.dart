import 'package:flutter/material.dart';
import 'package:kaktask/application/app_router.dart';
import 'package:kaktask/views/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then(
      (value) => AppRouter.push(
        context,
        const HomePage(name: 'Musfique',),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
