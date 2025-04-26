import 'package:flutter/material.dart';
import 'package:quicknsol_assignment/utils/config/app_colors.dart';

var lightTheme = ThemeData(
    scaffoldBackgroundColor: lightBgColor,
    appBarTheme: AppBarTheme(
        color: lightPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white)),
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      // fillColor: lightBgColor,
      // filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      fillColor: lightPrimaryColor.withOpacity(0.1),
      filled: true,
      prefixIconColor: lightLableColor,
      labelStyle: TextStyle(
        fontSize: 15,
        color: lightFontColor,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: TextStyle(
        fontSize: 15,
        color: lightFontColor,
        fontWeight: FontWeight.w500,
      ),
    ),
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      background: lightBgColor,
      onBackground: lightFontColor,
      primaryContainer: lightDivColor,
      onPrimaryContainer: lightFontColor,
      secondaryContainer: lightLableColor,
      primary: lightPrimaryColor,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 24,
        color: lightFontColor,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        color: lightFontColor,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        fontSize: 15,
        color: lightFontColor,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: lightFontColor,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        color: lightFontColor,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        color: lightFontColor,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontSize: 13,
        color: lightLableColor,
        fontWeight: FontWeight.w300,
      ),
    ));
