import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medina_stores/core/navigation/navigator.dart';

import '../../config/resources/languages.dart';
import '../../config/resources/locale_keys.g.dart';
import '../../features/user/presentation/presentation_imports.dart';
import '../error/exceptions.dart';
import 'api_constants.dart';
import 'api_request.dart';
import 'api_service.dart';
import 'log_interceptor.dart';
import 'response_model.dart';

class DioService implements ApiService {
  late final Dio _dio;

  DioService() {
    _initDio();
  }

  void _initDio() {
    _dio = Dio()
      ..options.baseUrl = ApiConstants.BASE_URL
      ..options.connectTimeout = const Duration(
        seconds: ApiConstants.connectTimeoutDurationInSeconds,
      )
      ..options.receiveTimeout = const Duration(
        seconds: ApiConstants.connectTimeoutDurationInSeconds,
      )
      ..options.responseType = ResponseType.json
      ..options.headers = {
        HttpHeaders.acceptHeader: ContentType.json,
      };

    if (kDebugMode) {
      _dio.interceptors.add(LoggerInterceptor());
    }
  }

  @override
  void addTokenToRequest(String token) {
    _dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
  }

  @override
  void removeTokenFromRequest() {
    _dio.options.headers.remove(HttpHeaders.authorizationHeader);
  }

  @override
  Future<ApiResponse<T>> callApi<T extends Object?>(ApiRequest networkRequest, {ApiResponse<T> Function(dynamic json)? mapper}) async {
    try {
      await networkRequest.prepareRequestData();
      final headers = networkRequest.headers ?? {};
      final token = AppNavigator.rootContext!.read<UserCubit>().state.user?.data?.token;
      headers.addEntries([
        MapEntry(
          'Accept-Language',
          Language.currentLanguage?.locale.languageCode ?? Language.english.languageCode,
        ),
        MapEntry(HttpHeaders.authorizationHeader, 'Bearer $token'),
      ]);
      final response = await _dio.request(
        networkRequest.path,
        data: networkRequest.hasBodyAndProgress()
            ? networkRequest.isFormData
                ? FormData.fromMap(networkRequest.body!)
                : networkRequest.body
            : networkRequest.body,
        queryParameters: networkRequest.queryParameters,
        onSendProgress: networkRequest.hasBodyAndProgress() ? networkRequest.onSendProgress : null,
        onReceiveProgress: networkRequest.hasBodyAndProgress() ? networkRequest.onReceiveProgress : null,
        options: Options(method: networkRequest.asString(), headers: headers),
      );
      if (mapper != null) {
        return mapper(response.data);
      } else {
        return ApiResponse.fromMapSuccess(response.data);
      }
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      throw UnknownException("${LocaleKeys.something_went_wrong.tr()} : ${e.toString()}");
    }
  }

  dynamic _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NoInternetConnectionException();
      case DioExceptionType.badResponse:
        switch (error.response!.statusCode) {
          case HttpStatus.badRequest:
            throw BadRequestException(ApiResponse.fromMapError(error.response));
          case HttpStatus.unprocessableEntity:
            throw MissingDataException(ApiResponse.fromMapError(error.response));
          case HttpStatus.unauthorized:
            throw UnauthorizedException(ApiResponse.fromMapError(error.response));
          case HttpStatus.notFound:
            throw NotFoundException(ApiResponse.fromMapError(error.response));
          case HttpStatus.conflict:
            throw ConflictException(ApiResponse.fromMapError(error.response));
          case HttpStatus.internalServerError:
            throw InternalServerErrorException();

          default:
            throw ServerException(ApiResponse.fromMapError(error.response));
        }
      case DioExceptionType.cancel:
        throw ServerException(ApiResponse.fromMapError(error.response));
      case DioExceptionType.unknown:
        throw UnknownException(
          error.response?.data['message'] ?? LocaleKeys.exception.tr(),
        );
      default:
        throw UnknownException(
          error.response?.data['message'] ?? LocaleKeys.exception.tr(),
        );
    }
  }
}
