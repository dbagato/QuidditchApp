import 'package:flutter/material.dart';

class AppThemeGlobal {
  static const Color primaryColor = Colors.green;
  static Color? secondaryColor = Colors.green[900];
  static const double iconSize = 30;
  static const double textSize = 20;
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    //color primario
    primaryColor: primaryColor,
    primaryTextTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
      bodyText2: TextStyle(
          fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),
    ),
    //Appbar
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      elevation: 10,
    ),
    //button style
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: primaryColor),
    ),
  );
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    //color primario
    primaryColor: secondaryColor,

    //Appbar
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      elevation: 10,
    ),
    //button style
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: primaryColor),
    ),
    primaryTextTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
      bodyText2: TextStyle(
          fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}
