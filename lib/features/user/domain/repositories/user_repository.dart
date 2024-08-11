part of '../domain_imports.dart';

abstract class UserRepository {
  Future<Either<Failure, ApiResponse<User>>> login(LoginParams params);
  Future<Either<Failure, ApiResponse<User>>> register(RegisterParams params);
  Future<Either<Failure, ApiResponse<Null>>> sendOTP(SendOTPParams params);
  Future<Either<Failure, ApiResponse<Null>>> logout();
}
