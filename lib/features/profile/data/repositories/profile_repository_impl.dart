part of '../data_imports.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  const ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ApiResponse<List<Profile>>>> getProfiles() async {
    return await remoteDataSource.getProfiles.handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<Profile>>> addProfile(AddProfileParams params) async {
    return await remoteDataSource.addProfile(params).handleCallbackWithFailure;
  }
}
