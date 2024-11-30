import 'dart:typed_data';

import '../../domain/check/entities/check.dart';

abstract class GenerateCheckService {
  Future<Uint8List> generateImage({required Check check});
}
