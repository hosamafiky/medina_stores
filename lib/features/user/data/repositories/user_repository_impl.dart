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
}
