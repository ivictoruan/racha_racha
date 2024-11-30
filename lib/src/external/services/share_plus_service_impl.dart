import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

import '../../infra/services/share_check_service.dart';

class SharePlusCheckServiceImpl extends ShareCheckService {
  final String _appUrl =
      'play.google.com/store/apps/details?id=com.matopibatech.racharacha';

  @override
  Future<bool> shareCheck({required Uint8List imageBytes}) async {
    final result = await Share.shareXFiles(
      [
        XFile.fromData(
          imageBytes,
          mimeType: 'image/png',
          name: 'racha_racha_conta.png',
        )
      ],
      text:
          'Confira nossa divisão de conta no Racha Racha!\n Baixe o app também: $_appUrl',
    );

    if (result.status == ShareResultStatus.success) {
      return true;
    }

    return false;
  }
}
