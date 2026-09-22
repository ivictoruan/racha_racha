import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../text/text_styles.dart';

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
        headlineSmall:
            TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w500),
        titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        titleMedium: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.w500,
            fontSize: 18),
        titleSmall: TextStyle(color: Colors.black87),
        bodyLarge: TextStyle(color: Colors.deepPurple),
        bodyMedium: TextStyle(color: Colors.deepPurple),
        bodySmall: TextStyle(color: Colors.deepPurple),
        labelLarge: TextStyle(
            color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 18)),
    snackBarTheme: SnackBarThemeData(
      showCloseIcon: true,
      backgroundColor: Colors.deepPurple[500],
      contentTextStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.deepPurple),
    listTileTheme: ListTileThemeData(
      titleTextStyle: TextStyles.mediumText(color: Colors.deepPurple),
      subtitleTextStyle: TextStyles.smallText(color: Colors.deepPurple),
    ),
  );
}
