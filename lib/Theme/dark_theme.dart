import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF1E1E1E),
    brightness: Brightness.dark,
  ).copyWith(
    primary: const Color(0xFFBB86FC),
    secondary: const Color(0xFF03DAC6),
    surface: const Color(0xFF1E1E1E),
    onPrimary: const Color(0xFF000000),
    onSecondary: const Color(0xFF000000),
    onSurface: const Color(0xFFE0E0E0),
  ),
  primaryColor: const Color(0xFFBB86FC),
  scaffoldBackgroundColor: const Color(0xFF121212),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    iconTheme: IconThemeData(color: Color(0xFFE0E0E0)),
    titleTextStyle: TextStyle(color: Color(0xFFE0E0E0), fontSize: 20),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFFE0E0E0), fontSize: 57),
    displayMedium: TextStyle(color: Color(0xFFE0E0E0), fontSize: 45),
    displaySmall: TextStyle(color: Color(0xFFE0E0E0), fontSize: 36),
    headlineLarge: TextStyle(color: Color(0xFFE0E0E0), fontSize: 32),
    headlineMedium: TextStyle(color: Color(0xFFE0E0E0), fontSize: 28),
    headlineSmall: TextStyle(color: Color(0xFFE0E0E0), fontSize: 24),
    titleLarge: TextStyle(color: Color(0xFFE0E0E0), fontSize: 22),
    titleMedium: TextStyle(color: Color(0xFFE0E0E0), fontSize: 16),
    titleSmall: TextStyle(color: Color(0xFFE0E0E0), fontSize: 14),
    bodyLarge: TextStyle(color: Color(0xFFE0E0E0), fontSize: 16),
    bodyMedium: TextStyle(color: Color(0xFFE0E0E0), fontSize: 14),
    bodySmall: TextStyle(color: Color(0xFFE0E0E0), fontSize: 12),
    labelLarge:
        TextStyle(color: Color.fromARGB(142, 224, 224, 224), fontSize: 14),
    labelMedium: TextStyle(color: Color(0xFFE0E0E0), fontSize: 12),
    labelSmall: TextStyle(color: Color(0xFFE0E0E0), fontSize: 11),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFFBB86FC),
    textTheme: ButtonTextTheme.primary,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF1E1E1E),
    labelStyle: TextStyle(color: Color(0xFFE0E0E0)),
    hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFE0E0E0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFE0E0E0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFBB86FC)),
    ),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xFFE0E0E0),
  ),
);
