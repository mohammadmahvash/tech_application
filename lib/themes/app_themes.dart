import 'package:flutter/material.dart';

import '../constant/my_colors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
      fontFamily: 'dana',
      inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      )),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              textStyle: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return const TextStyle(fontSize: 20);
                }
                return const TextStyle(fontSize: 18);
              }),
              backgroundColor:
                  MaterialStateProperty.all<Color>(SolidColors.primaryColor))),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: SolidColors.posterTitle),
        titleMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: SolidColors.blueColor),
        titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: SolidColors.posterSubTitle),
        headlineLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: SolidColors.textTitle),
        headlineMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: SolidColors.textTitle),
        headlineSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: SolidColors.primaryColor),
        labelSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: SolidColors.textTitle),
        labelMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: SolidColors.hintText),
        bodySmall: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: SolidColors.blueColor),
        bodyMedium: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: SolidColors.textTitle),
      ));
}
