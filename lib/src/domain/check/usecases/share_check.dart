import 'package:dartz/dartz.dart';

import '../errors/erros.dart';

abstract class ShareCheck {
  Future<Either<Failure, bool>> call();
}

class ShareCheckImpl implements ShareCheck {
  @override
  Future<Either<Failure, bool>> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
}
