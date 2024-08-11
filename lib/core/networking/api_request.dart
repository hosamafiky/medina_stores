import 'dart:io';

import 'package:dio/dio.dart';

enum RequestMethod { get, post, put, delete, patch }

class ApiRequest<GenericModel> {
  final String path;
  final RequestMethod method;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? headers;
  bool isFormData;
  final ProgressCallback? onSendProgress;
  final ProgressCallback? onReceiveProgress;

  ApiRequest({
    required this.method,
    required this.path,
    this.body,
    this.queryParameters,
    this.isFormData = false,
    this.onSendProgress,
    this.headers,
    this.onReceiveProgress,
  });

  ApiRequest copyWith({
    String? path,
    RequestMethod? method,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool? requestWithOutToken,
    bool? isFormData,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return ApiRequest(
      path: path ?? this.path,
      method: method ?? this.method,
      body: body ?? this.body,
      headers: headers ?? this.headers,
      queryParameters: queryParameters ?? this.queryParameters,
      isFormData: isFormData ?? this.isFormData,
      onSendProgress: onSendProgress ?? this.onSendProgress,
      onReceiveProgress: onReceiveProgress ?? this.onReceiveProgress,
    );
  }
}

extension NetworkRequestExtension on ApiRequest {
  bool get _canBeConvertedToFormData => hasBodyAndProgress() && body != null && body!.entries.isNotEmpty;

  bool hasBodyAndProgress() => method == RequestMethod.post || method == RequestMethod.put || method == RequestMethod.patch || method == RequestMethod.delete;

  String asString() {
    return method.toString().split('.').last.toUpperCase();
  }

  Future<void> prepareRequestData() async {
    if (_canBeConvertedToFormData) {
      final entries = body!.entries.toList();
      for (var i = 0; i < entries.length; i++) {
        final value = entries[i].value;
        if (value is File) {
          isFormData = true;
          body![entries[i].key] = await value.toMultiPart();
        } else if (value is List<File>) {
          isFormData = true;
          body![entries[i].key] = await value.toMultiPart();
        }
      }
    }
  }
}

extension MultiPartFileConverter on File {
  Future<MultipartFile> toMultiPart() async {
    return await MultipartFile.fromFile(path);
  }
}

extension MultiPartFileListConverter on List<File> {
  Future<List<MultipartFile>> toMultiPart() async {
    final List<MultipartFile> multipartFiles = [];
    for (final file in this) {
      multipartFiles.add(await file.toMultiPart());
    }
    return multipartFiles;
  }
}
