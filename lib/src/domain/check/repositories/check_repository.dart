import 'package:dartz/dartz.dart';

import '../entities/check.dart';
import '../errors/erros.dart';

abstract class CheckRepository {
  Future<Either<Failure, List<Check>>> getAllChecks();

  Future<Either<Failure, void>> deleteCheck({required Check check});

  Future<Either<Failure, void>> createCheck({required Check check});
}
