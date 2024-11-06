import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:racha_racha/src/domain/check/entities/check_model.dart';
import 'package:racha_racha/src/infra/services/database/check_database_service.dart';
import 'package:racha_racha/src/presenter/shared/controllers/check_controller.dart';

import 'check_controller_test.mocks.dart';

@GenerateMocks([CheckDatabaseService])
void main() {
  late CheckController controller;
  late MockCheckDatabaseService mockDbService;

  setUp(() {
    mockDbService = MockCheckDatabaseService();
    controller = CheckController(dbService: mockDbService);
  });

  test(
      'calculateCheckResult should calculate individual price without drinkers',
      () async {
    // Configuração inicial do modelo
    controller.check = CheckModel(
      totalValue: 100.0,
      totalWaiterValue: 10.0,
      totalPeople: 2,
      waiterPercentage: 10,
      isSomeoneDrinking: false,
    );

    // Chama a função e verifica o comportamento
    await controller.calculateCheckResult();

    // Verifica se o preço individual foi calculado corretamente
    expect(controller.individualPrice, 60.0);

    // Verifica se o método de criação no banco foi chamado uma vez
    verify(mockDbService.createCheck(check: controller.check)).called(1);
  });

  test('calculateCheckResult should calculate individual price with drinkers',
      () async {
    // Configuração inicial do modelo
    controller.check = CheckModel(
      totalValue: 200.0,
      totalWaiterValue: 40.0,
      totalPeople: 4,
      totalPeopleDrinking: 2,
      totalDrinkPrice: 40.0,
      waiterPercentage: 10,
      isSomeoneDrinking: true,
    );

    // Chama a função e verifica o comportamento
    await controller.calculateCheckResult();

    // Verifica se o preço individual de quem bebeu foi calculado corretamente
    expect(controller.individualPriceWhoIsDrinking, 70.0);

    // Verifica se o método de criação no banco foi chamado uma vez
    verify(mockDbService.createCheck(check: controller.check)).called(1);
  });
}
