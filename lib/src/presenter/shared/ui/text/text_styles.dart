import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle smallText({Color color = Colors.black, bold = false}) {
    return TextStyle(
      fontSize: 12,
      color: color,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
  }

  static TextStyle hintText = const TextStyle(
    fontSize: 16,
    color: Colors.grey,
    fontWeight: FontWeight.normal,
  );

  static TextStyle mediumText({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
    double fontSize = 16,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle mediumTextBold({
    Color color = Colors.deepPurple,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 16,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }
}
