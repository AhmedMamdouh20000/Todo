import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme {
  static Color primary = Color(0xff5D9CEC);
  static Color backGroundColorLight = Color(0xffDFECDB);
  static Color backGroundColorDark = Color(0xff060E1E);
  static Color red = Color(0xffEC4B4B);
  static Color green = Color(0xff61E757);
  static Color grey = Color(0xffC8C9CB);
  static Color white = Color(0xffffffff);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: backGroundColorLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primary,
      unselectedItemColor: grey,
      backgroundColor: white,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: white,
      shape: CircleBorder(
        side: BorderSide(
          width: 4,
          color: white,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      backgroundColor: primary,
    ),),
    textTheme: TextTheme(
        titleMedium: TextStyle(
          fontSize: 18,
          color: primary,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          color: backGroundColorDark,
          fontWeight: FontWeight.w400,
        )),
  );

  static ThemeData darkTheme = ThemeData();
}
