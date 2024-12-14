extension DoubleCurrencyFormat on double {
  String toCurrency() => 'R\$${toStringAsFixed(2).replaceAll('.', ',')}';
}
