part of '../domain_imports.dart';

class LogoutUsecase implements UseCaseWithoutParam<ApiResponse<Null>> {
  final UserRepository repository;

  const LogoutUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<Null>>> call() async {
    return await repository.logout();
  }
}
