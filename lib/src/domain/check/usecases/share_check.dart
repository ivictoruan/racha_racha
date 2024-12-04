import 'package:dartz/dartz.dart';

import '../entities/check.dart';
import '../errors/erros.dart';
import '../services/check_sharing_service.dart';

abstract class ShareCheck {
  Future<Either<Failure, bool>> call({required Check check});
}

class ShareCheckImpl implements ShareCheck {
  final CheckSharingService _sharingService;

  ShareCheckImpl({required CheckSharingService sharingService})
      : _sharingService = sharingService;

  @override
  Future<Either<Failure, bool>> call({required Check check}) async {
    final imageResult = await _sharingService.generateCheckImage(check);

    return imageResult.fold(
      (failure) => Left(failure),
      (imagePath) async => await _sharingService.shareCheckImage(
        imageBytes: imagePath,
      ),
    );
  }
}
