import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//CLARO
ThemeData light = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFFFFFFFF),
  accentColor: Colors.lightBlue[800],
  scaffoldBackgroundColor: Color(0xFFFFFFFF),
  cardTheme: CardTheme(
    color: Color(0xFFF1F1F1),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Color(0xFFF9F9F9),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(color: Colors.deepPurple),
    selectedLabelStyle: TextStyle(color: Colors.deepPurple),
    showSelectedLabels: false,
    showUnselectedLabels: false,
    backgroundColor: Color(0xFFE5E5E5),
  ),
  inputDecorationTheme: InputDecorationTheme(
      fillColor: Color(0xFFF1F1F1),
      focusColor: Colors.lightBlue[800],
      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.lightBlue[800]!,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[800]!,
          ),
          borderRadius: BorderRadius.circular(10.0)),
      border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[800]!,
          ),
          borderRadius: BorderRadius.circular(10.0))),
  accentTextTheme: TextTheme(
    headline1: TextStyle(color: Colors.lightBlue[700]),
    headline2: TextStyle(color: Color(0xFFF1F1F1)),
  ),
  bottomAppBarColor: Color(0xFFE6E6E6),
);

//ESCURO
ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF202022),
  accentColor: Color(0xFF725F5B),
  scaffoldBackgroundColor: Color(0xFF202022),
  cardTheme: CardTheme(
    color: Color(0xFF262628),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Color(0xFF303032),
  ),
  inputDecorationTheme: InputDecorationTheme(
      fillColor: Color(0xFF262628),
      focusColor: Color(0xFF725F5B),
      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF725F5B),
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[800]!,
          ),
          borderRadius: BorderRadius.circular(10.0)),
      border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[800]!,
          ),
          borderRadius: BorderRadius.circular(10.0))),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(color: Color(0xFFA590D5)),
    selectedLabelStyle: TextStyle(color: Color(0xFFA590D5)),
    showSelectedLabels: false,
    showUnselectedLabels: false,
    backgroundColor: Color(0xFF151517),
  ),

  bottomAppBarColor: Color(0xFF151517),
  accentTextTheme: TextTheme(
    headline1: TextStyle(color: Color(0xFFa8938f)),
    headline2: TextStyle(color: Color(0xFF000000)),
  ),
);

class ThemeNotifier extends ChangeNotifier {
  final String key = 'valorTema';
  late SharedPreferences prefs;
  late bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    prefs.setBool(key, _darkTheme);
  }
}
