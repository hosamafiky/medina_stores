part of '../data_imports.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  const UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ApiResponse<User>>> login(LoginParams params) async {
    return await remoteDataSource.login(params).handleCallbackWithFailure;
  }
}
