import 'package:dartz/dartz.dart';

import '../entities/check.dart';
import '../errors/erros.dart';
import '../repositories/check_repository.dart';

abstract class CreateCheck {
  Future<Either<Failure, void>> call({required Check check});
}

class CreateCheckImpl implements CreateCheck {
  final CheckRepository repository;

  CreateCheckImpl({required this.repository});

  @override
  Future<Either<Failure, void>> call({required Check check}) {
    return repository.createCheck(check: check);
  }
}
