import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {

  //theme provider
  //this is responsible for switching from dark mode tp light mode
  final String key = 'theme';
  SharedPreferences? _prefs;
  bool _darkTheme = false;
  bool get dark => _darkTheme;

  AppProvider() {
    _darkTheme = true;
    _loadfromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadfromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs!.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs!.setBool(key, _darkTheme);
    notifyListeners();
  }
}
