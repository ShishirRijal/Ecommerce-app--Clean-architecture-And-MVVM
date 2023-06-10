import 'package:flutter/material.dart';

enum Language { english, nepali }

const String english = "en";
const String nepali = "ar";
const String localizationAssetsPath = 'assets/translations';
const Locale nepaliLocal = Locale('ar', 'SA');
const Locale englishLocal = Locale('en', 'US');

extension LanguageManager on Language {
  String get languageCode {
    switch (this) {
      case Language.english:
        return english;
      case Language.nepali:
        return nepali;
      default:
        return english;
    }
  }
}
