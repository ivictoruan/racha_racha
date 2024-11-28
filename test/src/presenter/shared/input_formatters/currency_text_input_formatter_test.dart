import 'package:flutter_test/flutter_test.dart';
import 'package:racha_racha/src/presenter/shared/input_formatters/currency_text_input_formatter.dart';

void main() {
  group('CurrencyTextInputFormatter', () {
    final formatter = CurrencyTextInputFormatter();

    test('formata corretamente o valor inserido', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '1234');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, 'R\$ 12,34');
    });

    test('formata corretamente ao adicionar dígitos', () {
      const oldValue = TextEditingValue(text: 'R\$ 1,23');
      const newValue = TextEditingValue(text: '12345');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, 'R\$ 123,45');
    });

    test('mantém o campo vazio se o novo valor for vazio', () {
      const oldValue = TextEditingValue(text: 'R\$ 12,34');
      const newValue = TextEditingValue(text: '');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, '');
    });

    test('remove caracteres não permitidos', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '12a3b4');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, 'R\$ 12,34');
    });

    test('limita o número máximo de caracteres', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '12345678901234567890');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      // Garante que o texto está formatado dentro do limite especificado
      expect(result.text.length <= formatter.maxLength + 4, true); // +4 inclui "R\$ " e ",00"
    });
  });
}
