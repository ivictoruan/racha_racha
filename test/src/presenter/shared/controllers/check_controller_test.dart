import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:racha_racha/src/domain/check/usecases/create_check.dart';
import 'package:racha_racha/src/domain/check/usecases/share_check.dart';
import 'package:racha_racha/src/presenter/shared/controllers/check_controller.dart';

class MockShareCheck extends Mock implements ShareCheck {}

class MockCreateCheck extends Mock implements CreateCheck {}

void main() {
  late CheckController controller;
  late MockShareCheck mockShareCheck;
  late MockCreateCheck mockCreateCheck;

  setUp(() {
    mockShareCheck = MockShareCheck();
    mockCreateCheck = MockCreateCheck();
    controller = CheckController(
      shareCheck: mockShareCheck,
      createCheck: mockCreateCheck,
    );
  });

  group('totalValue setter', () {
    test('Deve definir o totalValue corretamente quando o valor for válido',
        () {
      controller.totalValue = 100.0;

      expect(controller.totalValue, 100.0);
      expect(controller.msgError, "");
      expect(controller.state, CheckState.totalCheckValueValid);
    });

    test('Deve exibir mensagem de erro para valor total igual a zero', () {
      controller.totalValue = 0.0;

      expect(controller.totalValue, 0.0);
      expect(controller.msgError, "Digite o valor total da conta");
      expect(controller.state, CheckState.totalCheckValueInvalid);
    });

    test('Deve notificar listeners ao alterar o totalValue', () {
      bool isNotified = false;
      controller.addListener(() {
        isNotified = true;
      });

      controller.totalValue = 200.0;

      expect(isNotified, isTrue);
    });
  });
}
