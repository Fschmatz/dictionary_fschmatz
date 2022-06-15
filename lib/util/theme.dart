import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  useMaterial3: true,
  textTheme: const TextTheme(
    titleMedium: TextStyle(fontWeight: FontWeight.w400),
  ),
  brightness: Brightness.light,
  primaryColor: const Color(0xFFFFFFFF),
  snackBarTheme: SnackBarThemeData(
    actionTextColor: Colors.green.shade700,
  ),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  colorScheme: ColorScheme.light(
      background: const Color(0xFFF0F2F2),
      primary: Colors.green.shade700,
      secondary: Colors.green.shade700),
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Color(0xFFFFFFFF),
    color: Color(0xFFFFFFFF),
    elevation: 0,
  ),
  cardTheme: const CardTheme(
    surfaceTintColor: Color(0xFFF1F1F1),
    color: Color(0xFFF1F1F1),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFFF9F9F9),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    backgroundColor: Color(0xFFFFFFFF),
  ),
  inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF1F2F1),
      focusColor: Colors.lightGreen[700],
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.lightGreen[700]!,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(8.0)),
      border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(8.0))),
  accentTextTheme: TextTheme(
    headline1: TextStyle(color: Colors.lightGreen[700]),
    headline2: const TextStyle(color: Color(0xFFF1F1F1)),
  ),
  bottomAppBarColor: const Color(0xFFE6E6E6),
);

ThemeData dark = ThemeData(
  useMaterial3: true,
  textTheme: const TextTheme(
    titleMedium: TextStyle(fontWeight: FontWeight.w400),
  ),
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF202022),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xFFF0F0F0),
    actionTextColor: Color(0xFF76AC5B),
  ),
  scaffoldBackgroundColor: const Color(0xFF202022),
  colorScheme: const ColorScheme.dark(
      background: Color(0xFF1C1C1D),
      primary: Color(0xFF76AC5B),
      secondary: Color(0xFF76AC5B)),
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Color(0xFF202022),
    color: Color(0xFF202022),
    elevation: 0,
  ),
  cardTheme: const CardTheme(
    surfaceTintColor: Color(0xFF303032),
    color: Color(0xFF303032),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFF303032),
  ),
  inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF303032),
      focusColor: const Color(0xFF76AC5B),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFF76AC5B),
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(8.0)),
      border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(8.0))),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(color: Color(0xFFA590D5)),
    selectedLabelStyle: TextStyle(color: Color(0xFFA590D5)),
    showSelectedLabels: false,
    showUnselectedLabels: false,
    backgroundColor: Color(0xFF202022),
  ),
  bottomAppBarColor: const Color(0xFF151517),
  accentTextTheme: const TextTheme(
    headline1: TextStyle(color: Color(0xFFA1CF8A)),
    headline2: TextStyle(color: Color(0xFF000000)),
  ),
);
