import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.pink,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
      ),
    ),
  );
}