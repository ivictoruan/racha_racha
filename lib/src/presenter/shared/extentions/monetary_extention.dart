// TODO: avaliar a necessidade desta extension
extension StringExtension on String {
  String convertCurrencyValues() {
    String valueWithoutSymbol = replaceAll(',', '.').replaceAll('R\$', '').trim();
    return valueWithoutSymbol;
  }
}


extension StringExtensions on String {
  double? parseCurrency() {
    // Remove caracteres que não sejam dígitos ou vírgula/ponto
    String cleanedText = replaceAll(RegExp(r'[^\d,\.]'), '').trim();

    // Substitui a última vírgula ou ponto por um ponto decimal
    int lastComma = cleanedText.lastIndexOf(',');
    int lastDot = cleanedText.lastIndexOf('.');

    if (lastComma > lastDot) {
      cleanedText = cleanedText.replaceRange(lastComma, lastComma + 1, '.');
      cleanedText = cleanedText.replaceAll(',', '');
    } else if (lastDot > lastComma) {
      cleanedText = cleanedText.replaceRange(lastDot, lastDot + 1, '.');
      cleanedText = cleanedText.replaceAll('.', '');
    }

    // Tenta converter o texto limpo para double
    return double.tryParse(cleanedText);
  }
}