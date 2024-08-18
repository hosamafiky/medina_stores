import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../../config/resources/locale_keys.g.dart';
import '../standards/response_model.dart';

class ServerException extends Equatable implements Exception {
  final ApiResponse response;

  const ServerException(this.response);

  @override
  String toString() => response.toString();

  @override
  List<Object?> get props => [response];
}

class FetchDataException extends ServerException {
  const FetchDataException(super.response);
}

class BadRequestException extends ServerException {
  const BadRequestException(super.response);
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException(super.response);
}

class MissingDataException extends ServerException {
  const MissingDataException(super.response);
}

class NotFoundException extends ServerException {
  const NotFoundException(super.response);
}

class ConflictException extends ServerException {
  const ConflictException(super.response);
}

class InternalServerErrorException extends ServerException {
  InternalServerErrorException() : super(ApiResponse.error(message: LocaleKeys.server_error.tr()));
}

class NoInternetConnectionException extends ServerException {
  NoInternetConnectionException() : super(ApiResponse.error(message: LocaleKeys.check_internet.tr()));
}

class CacheException implements Exception {}

class UnknownException implements Exception {
  final String message;

  const UnknownException(this.message);

  @override
  String toString() => "UnknownException: $message";
}
