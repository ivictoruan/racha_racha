import 'package:flutter_test/flutter_test.dart';
import 'package:racha_racha/src/presenter/shared/constants/space_constants.dart';

void main() {
  group('SpaceConstants', () {
    test('extraSmall should be 8', () {
      expect(SpaceConstants.extraSmall, equals(8.0));
    });

    test('small should be 12', () {
      expect(SpaceConstants.small, equals(12.0));
    });

    test('medium should be 16', () {
      expect(SpaceConstants.medium, equals(16.0));
    });

    test('screenBorder should be 20', () {
      expect(SpaceConstants.screenBorder, equals(20.0));
    });

    test('large should be 28', () {
      expect(SpaceConstants.large, equals(28.0));
    });

    test('extraLarge should be 56', () {
      expect(SpaceConstants.extraLarge, equals(56.0));
    });
  });
}
