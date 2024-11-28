import 'package:dartz/dartz.dart';
import 'package:racha_racha/src/domain/check/entities/check_model.dart';

import '../../domain/check/errors/erros.dart';
import '../../domain/check/entities/result_get_all_checks.dart';
import '../../domain/check/repositories/check_repository.dart';
import 'datasourcers/local_check_datasource.dart';

class CheckRepositoryImpl implements CheckRepository {
  final LocalCheckDatasource localDatasource;

  CheckRepositoryImpl({required this.localDatasource});

  @override
  Future<Either<Failure, ResultGetAllChecks>> getAllChecks() async {
    try {
      final result = await localDatasource.getAllChecks();
      return Right(result);
    } catch (e) {
      return Left(LocalDatasouceError(message: 'LocalDatasoucerError: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCheck({required String checkId}) async {
    try {
      final result = await localDatasource.deleteCheck(checkId: checkId);
      return Right(result);
    } catch (e) {
      return Left(LocalDatasouceError(message: 'LocalDatasoucerError: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> createCheck({required CheckModel check}) async {
    try {
      final result = await localDatasource.createCheck(check: check);

      return Right(result);
    } catch (e) {
      return Left(LocalDatasouceError(message: 'LocalDatasoucerError: $e'));
    }
  }
}