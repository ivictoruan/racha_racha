import 'package:dartz/dartz.dart';

import '../../../domain/check/entities/check.dart';
import '../../../domain/check/errors/erros.dart';
import '../../../domain/check/repositories/check_repository.dart';
import '../datasourcers/local_check_datasource.dart';

class CheckRepositoryImpl implements CheckRepository {
  final LocalCheckDatasource localDatasource;

  CheckRepositoryImpl({required this.localDatasource});

  @override
  Future<Either<Failure, List<Check>>> getAllChecks() async {
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
  Future<Either<Failure, void>> createCheck({required Check check}) async {
    try {
      final result = await localDatasource.createCheck(check: check);

      return Right(result);
    } catch (e) {
      return Left(LocalDatasouceError(message: 'LocalDatasoucerError: $e'));
    }
  }
}
