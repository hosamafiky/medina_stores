import 'package:equatable/equatable.dart';

import '../networking/response_model.dart';

class Failure extends Equatable {
  final ApiResponse response;

  const Failure({required this.response});

  @override
  List<Object> get props => [response];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.response});
}

class FetchDataFailure extends Failure {
  const FetchDataFailure({required super.response});
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({required super.response});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({required super.response});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.response});
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
