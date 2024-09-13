extension StringExtension on String {
  String convertCurrencyValues() {
    String valueWithoutSymbol = replaceAll(',', '.').replaceAll('R\$', '').trim();
    return valueWithoutSymbol;
  }
}
