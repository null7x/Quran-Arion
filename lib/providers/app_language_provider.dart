import 'package:flutter/material.dart';
import 'package:quran_arion/utils/translations.dart';

class AppLanguageProvider extends ChangeNotifier {
  Locale _locale = Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale newLocale) {
    if (!['en', 'ar', 'ur', 'ru'].contains(newLocale.languageCode)) return;
    _locale = newLocale;
    Translations.currentLanguage = newLocale.languageCode;
    notifyListeners();
  }

  void toggleLanguage() {
    if (_locale.languageCode == 'en') {
      setLocale(Locale('ar'));
    } else if (_locale.languageCode == 'ar') {
      setLocale(Locale('ur'));
    } else if (_locale.languageCode == 'ur') {
      setLocale(Locale('ru'));
    } else {
      setLocale(Locale('en'));
    }
  }
}
