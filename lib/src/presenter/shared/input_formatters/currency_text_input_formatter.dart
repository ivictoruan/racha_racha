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
    final parsedValue = double.tryParse(cleanedText);
    if (parsedValue == null) return const TextEditingValue();
    final double value = parsedValue / 100;

    // Formata o texto final com o símbolo R$
    final String newText =
        "R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}";

    // Atualiza o valor no campo de texto e posiciona o cursor no final
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
