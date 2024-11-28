import 'package:dartz/dartz.dart';

import '../entities/check_model.dart';
import '../entities/result_get_all_checks.dart';
import '../errors/erros.dart';

abstract class CheckRepository {
  Future<Either<Failure, ResultGetAllChecks>> getAllChecks();

  Future<Either<Failure, void>> deleteCheck({required String checkId});

    Future<Either<Failure, void>> createCheck({required CheckModel check});
}
