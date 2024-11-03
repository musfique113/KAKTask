import 'package:flutter/material.dart';
import 'package:kaktask/application/app_router.dart';
import 'package:kaktask/views/all_tasks_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => AppRouter.replaceWith(context, const AllTaskScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(),
          Image.asset(
            'assets/images/logo.png',
            height: 120,
            width: 120,
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.2,
            child: const LinearProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
