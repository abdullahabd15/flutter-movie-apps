import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static const String is_logged_in = "IS_LOGGED_IN";
  static const String firebase_token = "FIREBASE_TOKEN";
  static const String tmdb_token = "TMDB_TOKEN";

  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> isLoggedIn() async {
    var prefs = await _prefs;
    return prefs.getBool(is_logged_in);
  }

  Future<void> setLoggedIn(bool isLoggedIn) async {
    var prefs = await _prefs;
    prefs.setBool(is_logged_in, isLoggedIn);
  }

  Future<String> getFirebaseToken() async {
    var prefs = await _prefs;
    return prefs.getString(firebase_token);
  }

  Future<void> setFirebaseToken(String firebaseToken) async {
    var prefs = await _prefs;
    prefs.setString(firebase_token, firebaseToken);
  }

  Future<String> getTmdbToken() async {
    var prefs = await _prefs;
    return prefs.getString(tmdb_token);
  }

  Future<void> setTmdbToken(String token) async {
    var prefs = await _prefs;
    prefs.setString(tmdb_token, token);
  }
}