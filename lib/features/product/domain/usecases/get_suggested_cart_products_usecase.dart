part of '../domain_imports.dart';

class GetSuggestedCartProductsUsecase extends UseCaseWithoutParam<ApiResponse<List<Product>>> {
  final ProductRepository repository;

  GetSuggestedCartProductsUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<List<Product>>>> call() async {
    return await repository.getSuggestedCartProducts();
  }
}
