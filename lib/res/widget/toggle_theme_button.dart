import 'package:flutter/material.dart';
import 'package:kaktask/view_model/theme_provider_view_model.dart';
import 'package:provider/provider.dart';

class ThemeToggleWidget extends StatelessWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProviderViewModel>(context);

    return IconButton(
      icon: Icon(
        themeProvider.themeMode == ThemeMode.dark
            ? Icons.dark_mode
            : Icons.light_mode,
      ),
      onPressed: () {
        if (themeProvider.themeMode == ThemeMode.dark) {
          themeProvider.setThemeMode(ThemeMode.light);
        } else {
          themeProvider.setThemeMode(ThemeMode.dark);
        }
      },
    );
  }
}
