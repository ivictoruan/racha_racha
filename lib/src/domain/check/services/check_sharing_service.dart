import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../entities/check.dart';
import '../errors/erros.dart';

abstract class CheckSharingService {
  Future<Either<Failure, Uint8List>> generateCheckImage(Check check);

  Future<Either<Failure, bool>> shareCheckImage(
      {required Uint8List imageBytes});
}
