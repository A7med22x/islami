import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xffE2BE7F);
  static const Color black = Color(0xff202020);
  static const Color white = Color(0xffFFFFFF);
  static const Color lightBrown = Color(0xff856B3F);
  static const Color brown = Color(0xffB19768);

  static ThemeData lightTheme = ThemeData();
  static ThemeData darkTheme = ThemeData(
    primaryColor: primary,
    appBarTheme: AppBarThemeData(
      backgroundColor: black,
      foregroundColor: primary,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
    ),
    scaffoldBackgroundColor: black,
    inputDecorationTheme: InputDecorationThemeData(
      fillColor: black.withValues(alpha: 0.7),
      filled: true,
      hintStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: white.withValues(alpha: 0.6),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primary,
      selectedItemColor: white,
      type: .fixed,
      showUnselectedLabels: false,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'QPC_Hafs',
        fontSize: 32,
        color: primary,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 16,
        fontWeight: .w500,
        color: Colors.white,
      ),
      displaySmall: TextStyle(fontSize: 36, fontWeight: .bold, color: white),
      headlineLarge: TextStyle(fontSize: 32, fontWeight: .bold, color: white),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: .bold, color: white),
      titleLarge: TextStyle(fontSize: 20, fontWeight: .bold, color: white),
      titleMedium: TextStyle(fontSize: 16, fontWeight: .bold, color: white),
      titleSmall: TextStyle(fontSize: 14, fontWeight: .bold, color: white),
    ),
  );
}
