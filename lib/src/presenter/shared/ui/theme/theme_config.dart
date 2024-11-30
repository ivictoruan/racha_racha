import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeConfig {
  ThemeConfig._();

  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      surface: Colors.white,
      primary: Colors.deepPurple,
      primaryContainer: Colors.deepPurple[50],
      onSurface: Colors.black87,
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.deepPurple,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.deepPurple,
        statusBarBrightness: Brightness.light,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.deepPurple),
      displayMedium: TextStyle(color: Colors.deepPurple),
      displaySmall: TextStyle(color: Colors.deepPurple),
      headlineLarge: TextStyle(color: Colors.deepPurple),
      headlineMedium: TextStyle(color: Colors.deepPurple),
      headlineSmall: TextStyle(color: Colors.deepPurple),
      titleLarge: TextStyle(color: Colors.deepPurple),
      titleMedium: TextStyle(color: Colors.deepPurple),
      titleSmall: TextStyle(color: Colors.deepPurple),
      bodyLarge: TextStyle(color: Colors.deepPurple),
      bodyMedium: TextStyle(color: Colors.deepPurple),
      bodySmall: TextStyle(color: Colors.deepPurple),
    ),
    snackBarTheme: SnackBarThemeData(
      showCloseIcon: true,
      backgroundColor: Colors.deepPurple[500],
      contentTextStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.deepPurple),
  );
}
