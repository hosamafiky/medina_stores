part of '../domain_imports.dart';

abstract class UserRepository {
  Future<Either<Failure, ApiResponse<User>>> login(LoginParams params);
}
