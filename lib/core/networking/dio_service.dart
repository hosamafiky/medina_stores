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
import '../standards/response_model.dart';
import 'api_constants.dart';
import 'api_request.dart';
import 'api_service.dart';
import 'log_interceptor.dart';

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
      if (mapper != null) return mapper(response.data);
      return ApiResponse.fromMapSuccess(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw UnknownException(ApiResponse.error(message: "${LocaleKeys.something_went_wrong.tr()} : ${e.toString()}"));
    }
  }

  AppException _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NoInternetConnectionException();
      case DioExceptionType.cancel:
        return CancelException(ApiResponse.fromMapError(error.response).copyWithError(
          statusCode: error.response?.statusCode,
        ));
      case DioExceptionType.unknown:
        return UnknownException(ApiResponse.error(message: "${LocaleKeys.something_went_wrong.tr()} : ${error.response?.data['message']}"));
      case DioExceptionType.badResponse:
        switch (error.response!.statusCode) {
          case HttpStatus.badRequest:
            return BadRequestException(ApiResponse.fromMapError(error.response).copyWithError(
              statusCode: HttpStatus.badRequest,
            ));
          case HttpStatus.unprocessableEntity:
            return MissingDataException(ApiResponse.fromMapError(error.response).copyWithError(
              statusCode: HttpStatus.unprocessableEntity,
            ));
          case HttpStatus.unauthorized:
            return UnauthorizedException(ApiResponse.fromMapError(error.response).copyWithError(
              statusCode: HttpStatus.unauthorized,
            ));
          case HttpStatus.notFound:
            return NotFoundException(ApiResponse.fromMapError(error.response).copyWithError(
              statusCode: HttpStatus.notFound,
            ));
          case HttpStatus.conflict:
            return ConflictException(ApiResponse.fromMapError(error.response).copyWithError(
              statusCode: HttpStatus.conflict,
            ));
          case HttpStatus.internalServerError:
            return InternalServerErrorException();
          default:
            return UnknownException(ApiResponse.error(message: "${LocaleKeys.something_went_wrong.tr()} : ${error.response?.data['message']}"));
        }
      default:
        return UnknownException(ApiResponse.error(message: "${LocaleKeys.something_went_wrong.tr()} : ${error.response?.data['message']}"));
    }
  }
}
