import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_arion/providers/app_language_provider.dart';

class Translations {
  static String currentLanguage = 'en';

  static const Map<String, Map<String, String>> translations = {
    'en': {
      'appTitle': 'Quran-Arion',
      'home': 'Home',
      'search': 'Search',
      'library': 'Library',
      'profile': 'Profile',
      'more': 'More',
      'favorites': 'Favorites',
      'bookmarks': 'Bookmarks',
      'history': 'History',
      'statistics': 'Statistics',
      'settings': 'Settings',
      'language': 'Language',
      'darkMode': 'Dark Mode',
      'appearance': 'Appearance',
      'textSettings': 'Text Settings',
      'fontSize': 'Font Size',
      'notifications': 'Notifications',
      'prayerNotifications': 'Prayer Notifications',
      'about': 'About',
      'version': 'Version',
    },
    'ar': {
      'appTitle': 'القرآن - آريون',
      'home': 'الرئيسية',
      'search': 'بحث',
      'library': 'المكتبة',
      'profile': 'الملف الشخصي',
      'more': 'المزيد',
      'favorites': 'المفضلة',
      'bookmarks': 'الإشارات',
      'history': 'السجل',
      'statistics': 'الإحصائيات',
      'settings': 'الإعدادات',
      'language': 'اللغة',
      'darkMode': 'الوضع المظلم',
      'appearance': 'المظهر',
      'textSettings': 'إعدادات النص',
      'fontSize': 'حجم الخط',
      'notifications': 'الإخطارات',
      'prayerNotifications': 'إخطارات الصلاة',
      'about': 'حول',
      'version': 'الإصدار',
    },
    'ur': {
      'appTitle': 'قرآن - آرئن',
      'home': 'گھر',
      'search': 'تلاش',
      'library': 'لائبریری',
      'profile': 'پروفائل',
      'more': 'مزید',
      'favorites': 'پسندیدہ',
      'bookmarks': 'نشانیاں',
      'history': 'تاریخ',
      'statistics': 'شماریات',
      'settings': 'سیٹنگز',
      'language': 'زبان',
      'darkMode': 'تاریک موڈ',
      'appearance': 'شکل و صورت',
      'textSettings': 'متن کی سیٹنگز',
      'fontSize': 'فونٹ سائز',
      'notifications': 'اطلاعات',
      'prayerNotifications': 'نماز کی اطلاعات',
      'about': 'کے بارے میں',
      'version': 'ورژن',
    },
    'ru': {
      'appTitle': 'Коран - Арион',
      'home': 'Главная',
      'search': 'Поиск',
      'library': 'Библиотека',
      'profile': 'Профиль',
      'more': 'Ещё',
      'favorites': 'Избранное',
      'bookmarks': 'Закладки',
      'history': 'История',
      'statistics': 'Статистика',
      'settings': 'Настройки',
      'language': 'Язык',
      'darkMode': 'Тёмный режим',
      'appearance': 'Внешний вид',
      'textSettings': 'Параметры текста',
      'fontSize': 'Размер шрифта',
      'notifications': 'Уведомления',
      'prayerNotifications': 'Уведомления о молитве',
      'about': 'О приложении',
      'version': 'Версия',
    },
    'tg': {
      'appTitle': 'Қуръон - Арион',
      'home': 'Асосӣ',
      'search': 'Ҷустуҷӯ',
      'library': 'Кутубхона',
      'profile': 'Профили',
      'more': 'Бештар',
      'favorites': 'Дӯстдоштаҳо',
      'bookmarks': 'Нишономаҳо',
      'history': 'Таърихча',
      'statistics': 'Оморишномаҳо',
      'settings': 'Танзимот',
      'language': 'Забон',
      'darkMode': 'Режими торик',
      'appearance': 'Намояндагӣ',
      'textSettings': 'Танзимоти матн',
      'fontSize': 'Андозаи ҳарф',
      'notifications': 'Оғозор',
      'prayerNotifications': 'Оғозории намоз',
      'about': 'Дар бораи',
      'version': 'Нусхаи',
    },
  };

  static String translate(String languageCode, String key) {
    currentLanguage = languageCode;
    return translations[languageCode]?[key] ?? translations['en']?[key] ?? key;
  }

  static String get(String key) {
    return translations[currentLanguage]?[key] ?? translations['en']?[key] ?? key;
  }
}

extension TranslationExtension on BuildContext {
  String tr(String key) {
    final locale = Localizations.localeOf(this);
    return Translations.translate(locale.languageCode, key);
  }
}
