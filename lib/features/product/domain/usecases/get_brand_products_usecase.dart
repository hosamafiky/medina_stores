part of '../domain_imports.dart';

class GetBrandProductsUsecase implements UseCase<ApiResponse<PaginatedList<Product>>, GetBrandProductsParams> {
  final ProductRepository repository;

  const GetBrandProductsUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<Product>>>> call(GetBrandProductsParams param) async {
    return await repository.getBrandProducts(param);
  }
}

class GetBrandProductsParams extends GetPaginatedListParams {
  final int brandId;

  const GetBrandProductsParams({
    required this.brandId,
    super.page,
    super.perPage,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'filter[brand_id]': brandId,
      'page': page,
      'per_page': perPage,
    };
  }
}
