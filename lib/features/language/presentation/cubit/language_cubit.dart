part of '../presentation_imports.dart';

class LanguageCubit extends Cubit<Language> {
  LanguageCubit([Locale? savedLocale]) : super(Language.byLanguageCode(savedLocale?.languageCode ?? 'ar'));

  void changeLanguage(BuildContext context, Language language) {
    context.setLocale(language.locale);
    emit(language);
  }
}
