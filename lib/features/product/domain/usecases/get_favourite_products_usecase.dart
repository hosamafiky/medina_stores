part of '../domain_imports.dart';

class GetFavouriteProductsUsecase extends UseCase<ApiResponse<PaginatedList<ProductModel>>, GetPaginatedListParams> {
  final ProductRepository repository;

  GetFavouriteProductsUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<ProductModel>>>> call(GetPaginatedListParams param) async {
    return await repository.getFavoriteProducts(param);
  }
}
