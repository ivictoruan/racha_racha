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
      primaryContainer: const Color(0xFFD1C4E9),
      onSurface: Colors.black87,
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness
            .light, // Altera a cor do texto da barra de status para branco
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.deepPurple,
        statusBarBrightness:
            Brightness.light, // Define a barra de status como clara
        systemNavigationBarColor: Colors.white,
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
    iconTheme: const IconThemeData(color: Colors.deepPurple),
  );
}
