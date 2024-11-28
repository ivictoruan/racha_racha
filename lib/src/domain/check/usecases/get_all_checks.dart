import 'package:dartz/dartz.dart';

import '../entities/result_get_all_checks.dart';
import '../errors/erros.dart';
import '../repositories/check_repository.dart';

abstract class GetAllChecks {
  Future<Either<Failure, ResultGetAllChecks>> call();
}

class GetAllChecksImpl implements GetAllChecks {
  final CheckRepository repository;

  GetAllChecksImpl({
    required this.repository,
  });

  @override
  Future<Either<Failure, ResultGetAllChecks>> call() async {
    return repository.getAllChecks();
  }
}
