import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../domain/check/entities/check.dart';
import '../../../domain/check/errors/erros.dart';
import '../../../domain/check/services/check_sharing_service.dart';
import '../../services/generate_check_service.dart';
import '../../services/share_service.dart';

class CheckSharingServiceImpl implements CheckSharingService {
  final GenerateCheckService generateCheckService;
  final ShareService shareCheckService;

  CheckSharingServiceImpl({
    required this.generateCheckService,
    required this.shareCheckService,
  });

  @override
  Future<Either<Failure, Uint8List>> generateCheckImage(Check check) async {
    try {
      final result = await generateCheckService.generateImage(check: check);
      return Right(result);
    } catch (e) {
      return Left(
          CheckSharingServiceError(message: 'Failed to generate image: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> shareCheckImage({
    required Uint8List imageBytes,
  }) async {
    try {
      final result =
          await shareCheckService.shareCheckImage(imageBytes: imageBytes);
      return Right(result);
    } catch (e) {
      return Left(
        CheckSharingServiceError(message: 'Failed to generate image: $e'),
      );
    }
  }
}
