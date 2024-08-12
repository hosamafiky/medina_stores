part of '../domain_imports.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ApiResponse<List<Profile>>>> getProfiles();
  Future<Either<Failure, ApiResponse<Profile>>> addProfile(AddProfileParams params);
}
