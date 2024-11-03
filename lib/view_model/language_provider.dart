import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('en');
  final String _languageKey = 'selected_language';

  Locale get locale => _locale;

  LanguageProvider() {
    _loadLocale();
  }

  Future<void> toggleLanguage() async {
    _locale =
        _locale.languageCode == 'en' ? const Locale('bn') : const Locale('en');
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, _locale.languageCode);
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageKey) ?? 'en';
    _locale = Locale(languageCode);
    notifyListeners();
  }
}
