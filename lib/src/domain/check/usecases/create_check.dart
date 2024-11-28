import 'package:dartz/dartz.dart';

import '../errors/erros.dart';

abstract class CreateCheck {
  Future<Either<Failure, bool>> call();
}

class CreateCheckImpl implements CreateCheck {
  @override
  Future<Either<Failure, bool>> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
}
