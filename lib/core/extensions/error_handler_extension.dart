import 'package:dartz/dartz.dart';
import 'package:medina_stores/core/networking/response_model.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';

extension ErrorHandler<T extends Object> on Future<ApiResponse<T>> {
  Future<Either<Failure, ApiResponse<T>>> get handleCallbackWithFailure async {
    try {
      final result = await this;
      return Right(result);
    } on ServerException catch (e) {
      switch (e.response.statusCode) {
        case 400:
          return Left(BadRequestFailure(response: e.response));
        case 401:
          return Left(UnauthorizedFailure(response: e.response));
        case 404:
          return Left(NotFoundFailure(response: e.response));
        case 409:
          return Left(ConflictFailure(response: e.response));
        case 500:
          return Left(InternalServerErrorFailure(response: e.response));
        default:
          return Left(ServerFailure(response: e.response));
      }
    } on UnknownException catch (e) {
      return Left(UnknownFailure(response: ApiResponse.error(message: e.message)));
    }
  }
}
