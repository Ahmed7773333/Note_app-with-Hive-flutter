import 'package:flutter/material.dart';

class MyThemeData {
  static Color primaryColor = Color(0xFFB7935F);
  static Color blackColor = Color(0xFF242424);
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: TextTheme(
          bodySmall: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w400, color: blackColor),
          bodyMedium: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFFFFFF)),
          bodyLarge: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: blackColor)),
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: primaryColor, size: 30),
          color: Colors.transparent,
          elevation: 0.0,
          centerTitle: true),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: blackColor,
          unselectedItemColor: Colors.white,
          backgroundColor: primaryColor));
  static ThemeData darkTheme = ThemeData();
}
