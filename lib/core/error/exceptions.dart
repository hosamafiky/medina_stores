import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../../config/resources/locale_keys.g.dart';

class ServerException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const ServerException(this.message, this.statusCode);

  @override
  String toString() => "ServerException: $message, statusCode: $statusCode";

  @override
  List<Object?> get props => [message, statusCode];
}

class FetchDataException extends ServerException {
  const FetchDataException(super.message, super.statusCode);
}

class BadRequestException extends ServerException {
  const BadRequestException(super.message, super.statusCode);
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException(super.message, super.statusCode);
}

class MissingDataException extends ServerException {
  const MissingDataException(super.message, super.statusCode);
}

class NotFoundException extends ServerException {
  const NotFoundException(super.message, super.statusCode);
}

class ConflictException extends ServerException {
  const ConflictException(super.message, super.statusCode);
}

class InternalServerErrorException extends ServerException {
  InternalServerErrorException([message, statusCode]) : super(LocaleKeys.check_internet.tr(), statusCode);
}

class NoInternetConnectionException extends ServerException {
  NoInternetConnectionException([message, statusCode]) : super(LocaleKeys.check_internet.tr(), statusCode);
}

class CacheException implements Exception {}

class UnknownException implements Exception {
  final String message;

  const UnknownException(this.message);

  @override
  String toString() => "UnknownException: $message";
}
