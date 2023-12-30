
import 'package:flutter/services.dart';

class CurrencyTextInputFormatter extends TextInputFormatter {
  final int maxLength;

  CurrencyTextInputFormatter({this.maxLength = 15});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String cleanedText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanedText.length > maxLength) {
      cleanedText = cleanedText.substring(0, maxLength);
    }

    double value = double.parse(cleanedText) / 100;

    String newText = "R\$ ${value.toStringAsFixed(2)}";

    return newValue.copyWith(
      
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
