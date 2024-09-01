import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../../config/resources/locale_keys.g.dart';
import '../standards/response_model.dart';

class AppException extends Equatable implements Exception {
  final ApiResponse response;

  const AppException(this.response);

  @override
  String toString() => response.message;

  @override
  List<Object?> get props => [response.statusCode, response.message];
}

class FetchDataException extends AppException {
  const FetchDataException(super.response);
}

class BadRequestException extends AppException {
  const BadRequestException(super.response);
}

class CancelException extends AppException {
  const CancelException(super.response);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException(super.response);
}

class MissingDataException extends AppException {
  const MissingDataException(super.response);
}

class NotFoundException extends AppException {
  const NotFoundException(super.response);
}

class ConflictException extends AppException {
  const ConflictException(super.response);
}

class InternalServerErrorException extends AppException {
  InternalServerErrorException() : super(ApiResponse(message: LocaleKeys.server_error.tr()));
}

class NoInternetConnectionException extends AppException {
  NoInternetConnectionException() : super(ApiResponse(message: LocaleKeys.check_internet.tr()));
}

class CacheException extends AppException {
  const CacheException(super.response);
}

class UnknownException extends AppException {
  const UnknownException(super.response);
}
