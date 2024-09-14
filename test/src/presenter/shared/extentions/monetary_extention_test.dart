import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:racha_racha/src/presenter/shared/extentions/monetary_extention.dart';

void main() {
  group('StringExtension convertCurrencyValues', () {
    test('Deve remover o símbolo de moeda e retornar o valor sem formatação',
        () {
      String value = "R\$ 1234,56";
      log(value);
      String result = value.convertCurrencyValues();
      expect(result, "1234.56");
    });

    test('Deve remover o símbolo de moeda e retornar o valor sem espaços', () {
      String value = "R\$ 1234,56  ";
      String result = value.convertCurrencyValues();
      expect(result, "1234.56");
    });

    test(
        'Deve retornar a string original sem símbolo de moeda, se não houver formatação',
        () {
      String value = "1234.56";
      String result = value.convertCurrencyValues();
      expect(result, "1234.56");
    });

    test(
        'Deve retornar uma string vazia se o input for apenas o símbolo da moeda',
        () {
      String value = "R\$ ";
      String result = value.convertCurrencyValues();
      expect(result, "");
    });

    test('Deve lidar corretamente com valores sem separadores de milhar', () {
      String value = "R\$ 123456";
      String result = value.convertCurrencyValues();
      expect(result, "123456");
    });

    test('Deve remover espaços em branco antes e depois do valor', () {
      String value = "   R\$ 1234,56  ";
      String result = value.convertCurrencyValues();
      expect(result, "1234.56");
    });
  });
}
