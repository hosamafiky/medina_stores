part of '../domain_imports.dart';

class GetUserDataUsecase extends UseCaseWithoutParam<ApiResponse<UserProfile>> {
  final UserRepository repository;

  GetUserDataUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<UserProfile>>> call() async {
    return await repository.getUserProfile();
  }
}
