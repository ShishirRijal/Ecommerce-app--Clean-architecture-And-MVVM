import 'package:ecommerce_app/core.dart/resources/lanaguage_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const prefsLanguageKey = "APP_LANGUAGE_KEY";

class AppPreferences {
  final SharedPreferences _sharedPrefs;
  AppPreferences(this._sharedPrefs);

  Future<String> getAppLanaguage() async {
    String? result = _sharedPrefs.getString(prefsLanguageKey);
    return result ?? Language.english.languageCode;
  }
}
