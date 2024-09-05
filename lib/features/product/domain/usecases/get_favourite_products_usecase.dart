part of '../domain_imports.dart';

class GetFavouriteProductsUsecase extends UseCaseWithoutParam<ApiResponse<PaginatedList<ProductModel>>> {
  final ProductRepository repository;

  GetFavouriteProductsUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<ProductModel>>>> call() async {
    return await repository.getFavoriteProducts();
  }
}
