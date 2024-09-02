import '../error/exceptions.dart';
import '../error/failures.dart';

extension ErrorHandler<T extends Object?> on AppException {
  Failure get handleFailure {
    final e = this;
    switch (e.runtimeType) {
      case const (BadRequestException):
        return BadRequestFailure(response: e.response);
      case const (UnauthorizedException):
        return UnauthorizedFailure(response: e.response);
      case const (NotFoundException):
        return NotFoundFailure(response: e.response);
      case const (MissingDataException):
        return MissingDataFailure(response: e.response);
      case const (ConflictException):
        return ConflictFailure(response: e.response);
      case const (InternalServerErrorException):
        return InternalServerErrorFailure(response: e.response);
      case const (NoInternetConnectionException):
        return NoInternetConnectionFailure(response: e.response);
      case const (CacheException):
        return CacheFailure(response: e.response);
      default:
        return UnknownFailure(response: e.response);
    }
  }
}
