import 'package:dartz/dartz.dart';

import '../errors/erros.dart';

abstract class DeleteCheck {
  Future<Either<Failure, bool>> call();
}

class DeleteCheckImpl implements DeleteCheck {
  @override
  Future<Either<Failure, bool>> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
}
