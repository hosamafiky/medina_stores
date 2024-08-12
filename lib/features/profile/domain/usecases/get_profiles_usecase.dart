part of '../domain_imports.dart';

class GetProfilesUsecase implements UseCaseWithoutParam<ApiResponse<List<Profile>>> {
  final ProfileRepository repository;

  const GetProfilesUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<List<Profile>>>> call() async {
    return await repository.getProfiles();
  }
}

