import 'package:flutter/material.dart';
import 'package:kaktask/view_model/language_provider.dart';
import 'package:provider/provider.dart';

class LanguageSwitchButton extends StatelessWidget {
  const LanguageSwitchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return IconButton(
      icon: Icon(
        languageProvider.locale.languageCode == 'en'
            ? Icons.language
            : Icons.language,
      ),
      tooltip: languageProvider.locale.languageCode == 'en'
          ? 'Switch to Bengali'
          : 'Switch to English',
      onPressed: () => languageProvider.toggleLanguage(),
    );
  }
}
