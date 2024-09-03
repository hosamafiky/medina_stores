part of '../domain_imports.dart';

class GetCartItemsUsecase implements UseCaseWithoutParam<ApiResponse<List<Cart>>> {
  final CartRepository repository;

  const GetCartItemsUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<List<Cart>>>> call() async {
    return await repository.getCarts();
  }
}
