import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LanguageHelper {
  static const String _key = 'selected_locale';

  static Future<void> saveLocale(String localeCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, localeCode);
  }

  static Future<Locale> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key) ?? 'en';
    return Locale(code);
  }

  static Future<void> changeLocale(BuildContext context, Locale locale) async {
    await saveLocale(locale.languageCode);
    MyApp.of(context)
        ?.setLocale(locale); // assuming MyApp has a setLocale method
  }
}
