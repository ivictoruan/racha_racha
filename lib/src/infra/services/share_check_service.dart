import 'dart:typed_data';

abstract class ShareCheckService {
  Future<bool> shareCheck({required Uint8List imageBytes});
}
