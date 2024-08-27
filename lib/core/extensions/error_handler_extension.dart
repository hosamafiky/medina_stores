import 'package:dartz/dartz.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';
import '../standards/response_model.dart';

extension ErrorHandler<T extends Object?> on Future<ApiResponse<T>> {
  Future<Either<Failure, ApiResponse<T>>> get handleCallbackWithFailure async {
    try {
      final result = await this;
      return Right(result);
    } on AppException catch (e) {
      switch (e.runtimeType) {
        case const (BadRequestException):
          return Left(BadRequestFailure(response: e.response));
        case const (UnauthorizedException):
          return Left(UnauthorizedFailure(response: e.response));
        case const (NotFoundException):
          return Left(NotFoundFailure(response: e.response));
        case const (MissingDataException):
          return Left(MissingDataFailure(response: e.response));
        case const (ConflictException):
          return Left(ConflictFailure(response: e.response));
        case const (InternalServerErrorException):
          return Left(InternalServerErrorFailure(response: e.response));
        default:
          return Left(UnknownFailure(response: e.response));
      }
    }
  }
}
