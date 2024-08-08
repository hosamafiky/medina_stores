part of '../domain_imports.dart';

class GetProductsUsecase implements UseCaseWithoutParam<ApiResponse<List<Product>>> {
  final ProductRepository repository;

  const GetProductsUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<List<Product>>>> call() async {
    return await repository.getProducts();
  }
}
