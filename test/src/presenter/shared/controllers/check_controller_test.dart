import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:racha_racha/src/domain/check/entities/check.dart';
import 'package:racha_racha/src/domain/check/usecases/create_check.dart';
import 'package:racha_racha/src/domain/item/item.dart';
import 'package:racha_racha/src/presenter/shared/controllers/split_screen_controller.dart';

class MockCreateCheck extends Mock implements CreateCheck {}
class FakeCheck extends Fake implements Check {}

void main() {
  late SplitScreenController controller;
  late MockCreateCheck mockCreateCheck;

  setUpAll(() {
    registerFallbackValue(FakeCheck());
  });

  setUp(() {
    mockCreateCheck = MockCreateCheck();
    controller = SplitScreenController(createCheck: mockCreateCheck);
  });

  group('SplitScreenController', () {
    test('should add and remove participants correctly', () {
      controller.addParticipant('Alice');
      controller.addParticipant('Bob');

      expect(controller.participants.length, 2);
      expect(controller.participants.first.name, 'Alice');

      controller.removeParticipant(0);
      expect(controller.participants.length, 1);
      expect(controller.participants.first.name, 'Bob');
    });

    test('should not add duplicate participants', () {
      controller.addParticipant('Alice');
      controller.addParticipant('alice');

      expect(controller.participants.length, 1);
    });

    test('should add item and distribute cost proportionally', () {
      controller.addParticipant('Alice');
      controller.addParticipant('Bob');

      final alice = controller.participants[0];
      final bob = controller.participants[1];

      controller.addItem(
        item: Item(
          name: 'Pizza',
          price: 50.0,
          consumers: [alice, bob],
        ),
      );

      expect(controller.participants[0].total, 25.0);
      expect(controller.participants[1].total, 25.0);
    });

    test('should recalculate correctly when participant is removed', () {
      controller.addParticipant('Alice');
      controller.addParticipant('Bob');

      final alice = controller.participants[0];
      final bob = controller.participants[1];

      controller.addItem(
        item: Item(
          name: 'Pizza',
          price: 50.0,
          consumers: [alice, bob],
        ),
      );

      controller.removeParticipant(1); // remove Bob
      // Bob was removed from consumers, so Alice is sole consumer of Pizza
      expect(controller.participants.length, 1);
      expect(controller.participants[0].total, 50.0);
    });

    test('createCheck should return true on success', () async {
      when(() => mockCreateCheck.call(check: any(named: 'check')))
          .thenAnswer((_) async => const Right('check-id-123'));

      controller.addParticipant('Alice');
      final result = await controller.createCheck();

      expect(result, isTrue);
      expect(controller.id, 'check-id-123');
    });
  });
}

