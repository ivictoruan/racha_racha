import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeConfig {
  ThemeConfig._();

  /// A classe `ThemeConfig` fornece uma configuração para o tema do aplicativo.
  /// Define o tema padrão da aplicação, incluindo cores e estilos.

  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorSchemeSeed: Colors.deepPurple,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Color.fromARGB(255, 201, 177, 244),
        statusBarBrightness: Brightness.dark,
      ),
    ),
    // Configuração de estilos de texto
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
      displayLarge: TextStyle(
        // fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
      displayMedium: TextStyle(
        // fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
      bodyLarge: TextStyle(
        // fontSize: 16,
        color: Colors.deepPurple,
      ),
      bodyMedium: TextStyle(
        // fontSize: 14,
        color: Colors.deepPurple,
      ),
    ),
  );
}
