import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class ApiResponse<T extends Object?> extends Equatable {
  final int statusCode;
  final String message;
  final T? data;
  final bool isSuceess;
  final List<MapEntry<String, List<String>>> errors;

  const ApiResponse.success({
    this.statusCode = 200,
    this.message = '',
    required this.data,
    this.isSuceess = true,
  }) : errors = const [];

  const ApiResponse.error({
    this.statusCode = 0,
    required this.message,
    this.isSuceess = false,
    this.errors = const [],
  }) : data = null;

  factory ApiResponse.fromMapSuccess(
    Map<String, dynamic> map, {
    T Function(Map<String, dynamic>)? mapper,
  }) {
    return ApiResponse<T>.success(
      message: map['message'],
      data: T == Null
          ? null
          : mapper != null
              ? mapper(map)
              : map['data'],
      isSuceess: map['success'],
    );
  }

  factory ApiResponse.fromMapError(Response? response) {
    final data = response?.data;

    List<MapEntry<String, List<String>>> getErrors(Map<String, dynamic>? data) {
      if (data == null) return [];

      final errors = <MapEntry<String, List<String>>>[];
      for (var entry in data.entries) {
        errors.add(MapEntry<String, List<String>>(entry.key, entry.value.cast<String>()));
      }
      return errors;
    }

    final errors = getErrors(data['errors']);

    return ApiResponse<T>.error(
      message: data?['message'],
      isSuceess: data?['success'] ?? false,
      errors: errors,
    );
  }

  @override
  String toString() => 'ApiResponse(message: $message, data: $data, isSuceess: $isSuceess, errors: $errors)';

  ApiResponse<T> copyWithError({
    int? statusCode,
    String? message,
    List<MapEntry<String, List<String>>>? errors,
  }) {
    return ApiResponse<T>.error(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      errors: errors ?? this.errors,
    );
  }

  ApiResponse<T> copyWithSuccess({
    int? statusCode,
    String? message,
    T? data,
    bool? isSuccess,
  }) {
    return ApiResponse<T>.success(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      data: data ?? this.data,
      isSuceess: isSuccess ?? this.isSuceess,
    );
  }

  @override
  List<Object?> get props => [message, data, isSuceess, errors];
}
