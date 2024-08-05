import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  final int statusCode;

  const Failure({this.message = "", this.statusCode = 400});

  @override
  List<Object> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message, super.statusCode});

  @override
  List<Object> get props => [message, statusCode];
}

class FetchDataFailure extends Failure {
  const FetchDataFailure({super.message, super.statusCode});
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({super.message, super.statusCode});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.message, super.statusCode});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message, super.statusCode});
}

class ConflictFailure extends Failure {
  const ConflictFailure({super.message, super.statusCode});
}

class InternalServerErrorFailure extends Failure {
  const InternalServerErrorFailure({super.message, super.statusCode});
}

class NoInternetConnectionFailure extends Failure {
  const NoInternetConnectionFailure({super.message, super.statusCode});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message, super.statusCode});
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message, super.statusCode});
}
