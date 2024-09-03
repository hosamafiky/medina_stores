import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../config/resources/locale_keys.g.dart';
import '../error/exceptions.dart';
import '../standards/response_model.dart';

extension DioExceptionX on DioException {
  AppException get exceptionToThrow {
    final data = response?.data;
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NoInternetConnectionException();
      case DioExceptionType.cancel:
        return CancelException(ApiResponseModel.fromMap(data).copyWith(
          statusCode: response?.statusCode,
        ));
      case DioExceptionType.unknown:
        return UnknownException(
          ApiResponse(
            message: "${LocaleKeys.something_went_wrong.tr()} : ${response?.data['message']}",
          ),
        );
      case DioExceptionType.badResponse:
        switch (response!.statusCode) {
          case HttpStatus.badRequest:
            return BadRequestException(ApiResponseModel.fromMap(data).copyWith(
              statusCode: HttpStatus.badRequest,
            ));
          case HttpStatus.unprocessableEntity:
            return MissingDataException(ApiResponseModel.fromMap(data).copyWith(
              statusCode: HttpStatus.unprocessableEntity,
            ));
          case HttpStatus.unauthorized:
            return UnauthorizedException(ApiResponseModel.fromMap(data).copyWith(
              statusCode: HttpStatus.unauthorized,
            ));
          case HttpStatus.notFound:
            return NotFoundException(ApiResponseModel.fromMap(data).copyWith(
              statusCode: HttpStatus.notFound,
            ));
          case HttpStatus.conflict:
            return ConflictException(ApiResponseModel.fromMap(data).copyWith(
              statusCode: HttpStatus.conflict,
            ));
          case HttpStatus.internalServerError:
            return InternalServerErrorException();
          default:
            return UnknownException(ApiResponse(message: "${LocaleKeys.something_went_wrong.tr()} : ${data?.data['message']}"));
        }
      default:
        return UnknownException(ApiResponse(message: "${LocaleKeys.something_went_wrong.tr()} : ${data?.data['message']}"));
    }
  }
}
