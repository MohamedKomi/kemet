import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  late final Locale? locale;

  AppLocalization(this.locale);

  static LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationDelegate();

  static AppLocalization? of(BuildContext context) {
    return Localizations.of(context, AppLocalization);
  }

  late Map<String, dynamic> _localizedStrings;

  Future loadJsonLanguage(String selectedLanguageCode) async {
    Map<String, dynamic> jsonString = json.decode(
      await rootBundle
          .loadString('assets/languages/$selectedLanguageCode.json'),
    );
    _localizedStrings = jsonString.map(
      (key, value) {
        return MapEntry(key, value);
      },
    );
  }

  dynamic translate(String key) {
    return _localizedStrings[key];
  }
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar', 'ru', 'de'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization appLocalization = AppLocalization(locale);
    await appLocalization.loadJsonLanguage(locale.languageCode);
    return appLocalization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) =>
      false;
}

extension TranslateX on dynamic{
  dynamic tr(context){
    return AppLocalization.of(context)!.translate(this);
  }
}