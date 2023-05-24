enum Language { english, nepali }

const String english = "en";
const String nepali = "np";

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
