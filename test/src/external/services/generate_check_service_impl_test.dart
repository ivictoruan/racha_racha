import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_test/flutter_test.dart';
import 'package:racha_racha/src/domain/check/entities/check.dart';
import 'package:racha_racha/src/domain/item/item.dart';
import 'package:racha_racha/src/domain/participant/participant.dart';
import 'package:racha_racha/src/external/services/generate_check_service_impl.dart';

void main() {
  late GenerateCheckServiceImpl service;

  setUp(() {
    service = GenerateCheckServiceImpl();
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  test('generateImage retorna uma Uint8List não vazia', () async {
    final check = Check();
    final result = await service.generateImage(check: check);

    expect(result, isA<Uint8List>());
    expect(result.isNotEmpty, true);
  });

  test('generateImage cria uma imagem com as dimensões corretas', () async {
    final check = Check();
    final result = await service.generateImage(check: check);

    final codec = await ui.instantiateImageCodec(result);
    final frame = await codec.getNextFrame();

    expect(frame.image.width, 800);
    expect(frame.image.height, 700);
  });

  test('generateImage renderiza check completo com itens e participantes', () async {
    final p1 = Participant('Lucas')..total = 30.0;
    final p2 = Participant('Victor')..total = 20.0;

    final check = Check(
      participants: [p1, p2],
      items: [
        Item(name: 'Pizza', price: 40.0, consumers: [p1, p2]),
        Item(name: 'Suco', price: 10.0, consumers: [p1]),
      ],
    );

    final result = await service.generateImage(check: check);
    expect(result, isA<Uint8List>());
    expect(result.isNotEmpty, true);

    final codec = await ui.instantiateImageCodec(result);
    final frame = await codec.getNextFrame();

    expect(frame.image.width, 800);
    expect(frame.image.height, greaterThanOrEqualTo(700));
  });
}
