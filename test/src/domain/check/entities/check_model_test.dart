import 'package:flutter_test/flutter_test.dart';
import 'package:racha_racha/src/domain/check/entities/check.dart';
import 'package:racha_racha/src/domain/item/item.dart';
import 'package:racha_racha/src/domain/participant/participant.dart';

void main() {
  group('Check Entity', () {
    test('should initialize with default empty lists and zero totalValue', () {
      final model = Check();
      expect(model.participants, isEmpty);
      expect(model.items, isEmpty);
      expect(model.totalValue, 0.0);
    });

    test('should calculate totalValue as sum of all item prices', () {
      final p1 = Participant('Alice');
      final p2 = Participant('Bob');

      final item1 = Item(name: 'Pizza', price: 60.0, consumers: [p1, p2]);
      final item2 = Item(name: 'Refrigerante', price: 15.0, consumers: [p1]);

      final check = Check(
        participants: [p1, p2],
        items: [item1, item2],
      );

      expect(check.totalValue, 75.0);
    });

    test('copyWith should update fields correctly', () {
      final p1 = Participant('Alice');
      final check = Check(participants: [p1]);

      final updated = check.copyWith(id: '123');

      expect(updated.id, '123');
      expect(updated.participants.length, 1);
    });
  });
}
