import 'package:dartz/dartz.dart';
import '../repositories/check_repository.dart';

import '../entities/check.dart';
import '../errors/erros.dart';

abstract class DeleteCheck {
  Future<Either<Failure, void>> call({required Check check});
}

class DeleteCheckImpl implements DeleteCheck {
  final CheckRepository repository;

  DeleteCheckImpl({required this.repository});
  @override
  Future<Either<Failure, void>> call({required Check check}) {
    return repository.deleteCheck(check: check);
  }
}
