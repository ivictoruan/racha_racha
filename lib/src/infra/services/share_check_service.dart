import 'dart:typed_data';

abstract class ShareCheckService {
  Future<void> shareCheck({required Uint8List imageBytes});
}
