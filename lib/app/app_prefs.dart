import 'package:ecommerce_app/core.dart/resources/lanaguage_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const prefsLanguageKey = "APP_LANGUAGE_KEY";
const prefsIsUserLoggedIn = "IS_USER_LOGGED_IN";
const prefsOnboardingScreenViewed = "ONBOARDING_SCREEN_VIEWED";

class AppPreferences {
  final SharedPreferences _sharedPrefs;
  AppPreferences(this._sharedPrefs);

  Future<String> getAppLanaguage() async {
    String? result = _sharedPrefs.getString(prefsLanguageKey);
    return result ?? Language.english.languageCode;
  }

  Future<void> setOnboardingScreenViewed() async {
    _sharedPrefs.setBool(prefsOnboardingScreenViewed, false);
  }

  Future<void> setUserLoggedIn() async {
    _sharedPrefs.setBool(prefsIsUserLoggedIn, true);
  }

  Future<bool> isOnboardingScreenViewed() async {
    bool? result = _sharedPrefs.getBool(prefsOnboardingScreenViewed);
    return result ?? false;
  }

  Future<bool> isUserLoggedIn() async {
    bool? result = _sharedPrefs.getBool(prefsIsUserLoggedIn);
    return result ?? false;
  }

  // ! CAUTION: Clears all the data from shared preferences
  Future<void> clearAll() async {
    await _sharedPrefs.clear();
  }
}
