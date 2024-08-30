import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    // Use the isSupportedLocale method to check if the locale is supported
    if (!L10n.isSupportedLocale(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}

class L10n {
  static final all = [
    const Locale('en', ''), // English
    const Locale('hi', ''), // Hindi
  ];

  // Method to check if a locale is supported
  static bool isSupportedLocale(Locale locale) {
    return all.contains(locale);
  }

  // List of supported locales for the app
  static List<Locale> get supportedLocales => all;
}
