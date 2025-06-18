import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF6A38F3),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF6A38F3),
  scaffoldBackgroundColor: Colors.black,
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
  ),
);
