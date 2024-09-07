part of '../domain_imports.dart';

class GetLatestProductsUsecase extends UseCase<ApiResponse<PaginatedList<Product>>, GetPaginatedListParams> {
  final ProductRepository repository;

  GetLatestProductsUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<Product>>>> call(GetPaginatedListParams param) async {
    return await repository.getLatestProducts(param);
  }
}
