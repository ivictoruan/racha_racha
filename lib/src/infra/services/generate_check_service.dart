import 'dart:typed_data';

import '../../domain/check/entities/check_model.dart';

abstract class GenerateCheckService {
  Future<Uint8List> generateImage({
    required CheckModel check,
  });
}
