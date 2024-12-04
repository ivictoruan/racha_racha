import 'package:flutter_test/flutter_test.dart';
import 'package:racha_racha/src/domain/check/entities/check.dart';

void main() {
  group('CheckModel', () {
    test('should initialize with default values', () {
      final model = Check();
      expect(model.totalValue, 0);
      expect(model.individualPrice, 0);
      expect(model.waiterPercentage, 0);
      expect(model.totalWaiterValue, 0);
      expect(model.isSomeoneDrinking, false);
      expect(model.totalDrinkPrice, 0);
      expect(model.totalPeopleDrinking, 0);
      expect(model.individualPriceWhoIsDrinking, 0);
      expect(model.totalPeople, 1);
    });

    test('should initialize with custom values', () {
      final model = Check(
        totalValue: 100,
        individualPrice: 25,
        waiterPercentage: 10,
        totalWaiterValue: 10,
        isSomeoneDrinking: true,
        totalDrinkPrice: 40,
        totalPeopleDrinking: 2,
        individualPriceWhoIsDrinking: 20,
        totalPeople: 4,
      );

      expect(model.totalValue, 100);
      expect(model.individualPrice, 25);
      expect(model.waiterPercentage, 10);
      expect(model.totalWaiterValue, 10);
      expect(model.isSomeoneDrinking, true);
      expect(model.totalDrinkPrice, 40);
      expect(model.totalPeopleDrinking, 2);
      expect(model.individualPriceWhoIsDrinking, 20);
      expect(model.totalPeople, 4);
    });

    test('should handle zero values', () {
      final model = Check(
        totalValue: 0,
        totalPeople: 0,
        totalPeopleDrinking: 0,
      );

      expect(model.totalValue, 0);
      expect(model.totalPeople, 0);
      expect(model.totalPeopleDrinking, 0);
    });

    test('should handle large values', () {
      final model = Check(
        totalValue: 1000000,
        individualPrice: 500000,
        waiterPercentage: 20,
        totalWaiterValue: 200000,
        totalDrinkPrice: 300000,
        totalPeopleDrinking: 1000,
        individualPriceWhoIsDrinking: 300,
        totalPeople: 2000,
      );

      expect(model.totalValue, 1000000);
      expect(model.individualPrice, 500000);
      expect(model.waiterPercentage, 20);
      expect(model.totalWaiterValue, 200000);
      expect(model.totalDrinkPrice, 300000);
      expect(model.totalPeopleDrinking, 1000);
      expect(model.individualPriceWhoIsDrinking, 300);
      expect(model.totalPeople, 2000);
    });
  });
}
