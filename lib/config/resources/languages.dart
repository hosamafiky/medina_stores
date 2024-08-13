import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/navigation/navigator.dart';

enum Language {
  english(Locale('en'), 'English', "en"),
  arabic(Locale('ar'), 'Arabic', "ar");

  static Language byLanguageCode(String code) {
    return Language.values.firstWhere((element) => element.languageCode == code, orElse: () => Language.english);
  }

  final String title;
  final Locale locale;
  final String languageCode;

  const Language(this.locale, this.title, this.languageCode);

  static List<Locale> get supportedLocales => Language.values.map((e) => e.locale).toList();

  static List<String> get titles => Language.values.map((e) => e.title.tr()).toList();

  static setLocale(Language lang) => AppNavigator.rootContext?.setLocale(lang.locale);

  static setLocaleWithContext(BuildContext context, Language lang) => context.setLocale(lang.locale);

  static String getLanguageCode(Language language) => language.locale.languageCode;

  static Language? get currentLanguage {
    final currentLocale = EasyLocalization.of(AppNavigator.rootContext!)!.locale;
    return Language.values.firstWhere((element) => element.locale == currentLocale);
  }
}
