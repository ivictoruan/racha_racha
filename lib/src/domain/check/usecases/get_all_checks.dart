import 'package:dartz/dartz.dart';

import '../entities/check.dart';
import '../errors/erros.dart';
import '../repositories/check_repository.dart';

abstract class GetAllChecks {
  Future<Either<Failure, List<Check>>> call();
}

class GetAllChecksImpl implements GetAllChecks {
  final CheckRepository repository;

  GetAllChecksImpl({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Check>>> call() async {
    return repository.getAllChecks();
  }
}
