part of '../domain_imports.dart';

class DeleteAccountUsecase extends UseCaseWithoutParam<ApiResponse<Null>> {
  final UserRepository repository;

  DeleteAccountUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<Null>>> call() async {
    return await repository.deleteAccount();
  }
}
