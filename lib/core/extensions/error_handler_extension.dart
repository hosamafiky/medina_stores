import 'package:dartz/dartz.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';

extension ErrorHandler<T extends Object> on Future<T> {
  Future<Either<Failure, T>> get handleCallbackWithFailure async {
    try {
      final result = await this;
      return Right(result);
    } on ServerException catch (e) {
      switch (e.statusCode) {
        case 400:
          return Left(BadRequestFailure(message: e.message, statusCode: e.statusCode));
        case 401:
          return Left(UnauthorizedFailure(message: e.message, statusCode: e.statusCode));
        case 404:
          return Left(NotFoundFailure(message: e.message, statusCode: e.statusCode));
        case 409:
          return Left(ConflictFailure(message: e.message, statusCode: e.statusCode));
        case 500:
          return Left(InternalServerErrorFailure(message: e.message, statusCode: e.statusCode));
        default:
          return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
      }
    } on UnknownException catch (e) {
      return Left(UnknownFailure(message: e.message));
    }
  }
}
