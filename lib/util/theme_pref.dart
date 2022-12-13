import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePref{
  static const themeStatus = "THEMESTATUS";

 static setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeStatus, value);
  }

static  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeStatus) ?? false;
  }
}