import 'package:equatable/equatable.dart';

class ApiResponse<T extends Object?> extends Equatable {
  final int statusCode;
  final String message;
  final T? data;
  final bool isSuceess;
  final List<MapEntry<String, List<String>>> errors;

  const ApiResponse({
    this.statusCode = 0,
    this.message = '',
    this.data,
    this.isSuceess = false,
    this.errors = const [],
  });

  ApiResponse<R> map<R>(R Function(T) mapper) {
    return ApiResponse<R>(
      statusCode: statusCode,
      message: message,
      data: data != null ? mapper(data as T) : null,
      isSuceess: isSuceess,
    );
  }

  @override
  String toString() => 'ApiResponse(message: $message, data: $data, isSuceess: $isSuceess, errors: $errors)';

  ApiResponse<T> copyWith({
    int? statusCode,
    T? data,
    String? message,
    List<MapEntry<String, List<String>>>? errors,
  }) {
    return ApiResponse<T>(
      statusCode: statusCode ?? this.statusCode,
      data: data ?? this.data,
      message: message ?? this.message,
      errors: errors ?? this.errors,
    );
  }

  @override
  List<Object?> get props => [message, data, isSuceess, errors];
}

class ApiResponseModel<T extends Object?> extends ApiResponse<T> {
  const ApiResponseModel({
    super.statusCode = 0,
    super.message = '',
    super.data,
    super.isSuceess = false,
    super.errors = const [],
  });

  const ApiResponseModel.error({required super.message});

  factory ApiResponseModel.fromMap(
    Map<String, dynamic> map, {
    T Function(Map<String, dynamic>)? mapper,
  }) {
    List<MapEntry<String, List<String>>> getErrors(Map<String, dynamic>? data) {
      if (data == null) return [];

      final errors = <MapEntry<String, List<String>>>[];
      for (var entry in data.entries) {
        errors.add(MapEntry<String, List<String>>(entry.key, entry.value.cast<String>()));
      }
      return errors;
    }

    final errors = getErrors(map['errors']);

    return ApiResponseModel<T>(
      message: map['message'] ?? '',
      data: T == Null
          ? null
          : mapper != null
              ? mapper(map)
              : map['data'],
      isSuceess: map['success'] ?? false,
      errors: errors,
    );
  }
}
