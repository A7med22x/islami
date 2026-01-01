import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xffE2BE7F);
  static const Color black = Color(0xff202020);
  static const Color white = Color(0xffFFFFFF);

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
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primary,
      selectedItemColor: white,
      type: .fixed,
      showUnselectedLabels: false,
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(fontSize: 24, fontWeight: .bold, color: white),
      titleLarge: TextStyle(fontSize: 20, fontWeight: .bold, color: white),
      titleMedium: TextStyle(fontSize: 16, fontWeight: .bold, color: white),
      titleSmall: TextStyle(fontSize: 14, fontWeight: .bold, color: white),
    ),
  );
}
