part of '../data_imports.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  const UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ApiResponse<User>>> login(LoginParams params) async {
    return await remoteDataSource.login(params).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<User>>> register(RegisterParams params) async {
    return await remoteDataSource.register(params).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<Null>>> logout() async {
    return await remoteDataSource.logout().handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<Null>>> sendOTP(SendOTPParams params) async {
    return await remoteDataSource.sendOTP(params).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<User>>> verifyOTP(String otp) async {
    return await remoteDataSource.verifyOTP(otp).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<Null>>> verifyPasswordOTP(String otp) async {
    return await remoteDataSource.verifyPasswordOTP(otp).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<Null>>> resetPassword(ResetPasswordParams params) async {
    return await remoteDataSource.resetPassword(params).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<UserProfile>>> getUserProfile() async {
    return await remoteDataSource.getUserProfile().handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<Null>>> updateProfile(UpdateProfileParams params) async {
    return await remoteDataSource.updateProfile(params).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<Null>>> deleteAccount() async {
    return await remoteDataSource.deleteAccount().handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<Null>>> updateUserPassword(UpdatePasswordParams params) async {
    return await remoteDataSource.updateUserPassword(params).handleCallbackWithFailure;
  }
}
