part of '../domain_imports.dart';

class GetSearchProductsUsecase extends UseCase<ApiResponse<PaginatedList<Product>>, String> {
  final ProductRepository repository;

  GetSearchProductsUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<Product>>>> call(String param) async {
    return await repository.getSearchProducts(param);
  }
}
