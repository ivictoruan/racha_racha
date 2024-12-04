import 'dart:typed_data';

abstract class ShareService {
  Future<bool> shareCheckImage({required Uint8List imageBytes});
}
