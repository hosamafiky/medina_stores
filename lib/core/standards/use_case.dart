import 'package:dartz/dartz.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Param> {
  Future<Either<Failure, Type>> call(Param param);
  // i use [] to make param optional
}

abstract class UseCaseWithoutParam<Type> {
  Future<Either<Failure, Type>> call();
  // i use [] to make param optional
}
