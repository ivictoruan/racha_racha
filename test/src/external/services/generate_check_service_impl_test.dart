import 'package:flutter_test/flutter_test.dart';
import 'package:racha_racha/src/domain/check/entities/check_model.dart';
import 'package:racha_racha/src/external/services/generate_check_service_impl.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

void main() {
  late GenerateCheckServiceImpl service;

  setUp(() {
    service = GenerateCheckServiceImpl();
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  test('generateImage retorna uma Uint8List não vazia', () async {
    final check = CheckModel(
      totalValue: 100,
      individualPrice: 25,
      waiterPercentage: 10,
      totalWaiterValue: 10,
      isSomeoneDrinking: false,
      totalPeople: 4,
    );

    final result = await service.generateImage(check: check);

    expect(result, isA<Uint8List>());
    expect(result.isNotEmpty, true);
  });

  test('generateImage cria uma imagem com as dimensões corretas', () async {
    final check = CheckModel(
      totalValue: 100,
      individualPrice: 25,
      waiterPercentage: 10,
      totalWaiterValue: 10,
      isSomeoneDrinking: false,
      totalPeople: 4,
    );

    final result = await service.generateImage(check: check);

    final codec = await ui.instantiateImageCodec(result);
    final frame = await codec.getNextFrame();

    expect(frame.image.width, 800);
    expect(frame.image.height, 700);
  });
}
