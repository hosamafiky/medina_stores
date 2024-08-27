import 'package:equatable/equatable.dart';

import '../standards/response_model.dart';

class Failure extends Equatable {
  final ApiResponse response;

  const Failure({required this.response});

  @override
  List<Object> get props => [response];
}

class FetchDataFailure extends Failure {
  const FetchDataFailure({required super.response});
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({required super.response});
}

class CancelFailure extends Failure {
  const CancelFailure({required super.response});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({required super.response});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.response});
}

class MissingDataFailure extends Failure {
  const MissingDataFailure({required super.response});
}

class ConflictFailure extends Failure {
  const ConflictFailure({required super.response});
}

class InternalServerErrorFailure extends Failure {
  const InternalServerErrorFailure({required super.response});
}

class NoInternetConnectionFailure extends Failure {
  const NoInternetConnectionFailure({required super.response});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.response});
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.response});
}

extension FailureExt on Failure? {
  String? errorMessage(String key, [String? fallbackKey]) {
    if (this == null || this!.response.errors.isEmpty) return null;
    final index = this!.response.errors.map((e) => e.key).toList().indexOf(key);
    if (index != -1) {
      return this!.response.errors[index].value.join(', ');
    }
    if (fallbackKey != null) {
      final index = this!.response.errors.map((e) => e.key).toList().indexOf(fallbackKey);
      if (index != -1) {
        return this!.response.errors[index].value.join(', ');
      }
    }
    return null;
  }
}
