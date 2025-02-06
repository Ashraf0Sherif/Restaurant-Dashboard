import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData foodieTheme(context) {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF1E1E1E),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: ColorsStyles.kPrimaryColor,
      secondary: ColorsStyles.kSecondaryColor,
      surface: const Color(0xFF2C2C2C),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF2C2C2C),
      elevation: 0,
    ),
    cardTheme: const CardTheme(
      color: Color(0xFF2C2C2C),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorsStyles.kPrimaryColor;
        }
        return Colors.grey;
      }),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.white),
        shape: WidgetStateProperty.resolveWith<OutlinedBorder>((_) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          );
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return ColorsStyles.kPrimaryColor.withOpacity(0.1);
            }
            return Colors.transparent;
          },
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.white70),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorsStyles.kPrimaryColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorsStyles.kPrimaryColor,
          width: 1.8,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ColorsStyles.kCustomRedColor),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: ColorsStyles.kPrimaryColor.withOpacity(0.3),
      selectionHandleColor: Colors.white,
    ),
  );
}
