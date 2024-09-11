part of '../domain_imports.dart';

abstract class UserRepository {
  Future<Either<Failure, ApiResponse<User>>> login(LoginParams params);
  Future<Either<Failure, ApiResponse<User>>> register(RegisterParams params);
  Future<Either<Failure, ApiResponse<Null>>> sendOTP(SendOTPParams params);
  Future<Either<Failure, ApiResponse<User>>> verifyOTP(String otp);
  Future<Either<Failure, ApiResponse<Null>>> verifyPasswordOTP(String otp);
  Future<Either<Failure, ApiResponse<Null>>> resetPassword(ResetPasswordParams params);
  Future<Either<Failure, ApiResponse<UserProfile>>> getUserProfile();
  Future<Either<Failure, ApiResponse<Null>>> updateProfile(UpdateProfileParams params);
  Future<Either<Failure, ApiResponse<Null>>> updateUserPassword(UpdatePasswordParams params);
  Future<Either<Failure, ApiResponse<Null>>> deleteAccount();
  Future<Either<Failure, ApiResponse<Null>>> logout();
}
