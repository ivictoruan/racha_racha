import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle smallText({Color color = Colors.black, bold = false}) {
    return TextStyle(
      // fontFamily: 'Lato',
      fontSize: 12,
      color: color,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
  }

  static TextStyle hintText = const TextStyle(
    // fontFamily: 'Lato',
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
      // fontFamily: 'Lato',
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle mediumTextBold({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 16,
  }) {
    return TextStyle(
      fontFamily: 'Lato',
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }
}
