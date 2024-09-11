import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

import '../../infra/services/share_check_service.dart';

class SharePlusCheckServiceImpl extends ShareCheckService {
  @override
  Future<void> shareCheck({required Uint8List imageBytes}) async =>
      await Share.shareXFiles(
        [
          XFile.fromData(
            imageBytes,
            mimeType: 'image/png',
            name: 'racha_racha_conta.png',
          )
        ],
        text: 'Confira nossa divisão de conta no Racha Racha!',
      );
}
