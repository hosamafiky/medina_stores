part of '../domain_imports.dart';

class GetRelatedProductsUsecase extends UseCase<ApiResponse<List<Product>>, String> {
  final ProductRepository repository;

  GetRelatedProductsUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<List<Product>>>> call(String param) async {
    return await repository.getRelatedProducts(param);
  }
}
