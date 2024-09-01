part of '../domain_imports.dart';

class GetCategoryProductsUsecase implements UseCase<ApiResponse<PaginatedList<Product>>, GetCategoryProductsParams> {
  final ProductRepository repository;

  const GetCategoryProductsUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<Product>>>> call(GetCategoryProductsParams param) async {
    return await repository.getSubCategoryProducts(param);
  }
}

class GetCategoryProductsParams extends GetPaginatedListParams {
  final int subCategoryId;

  const GetCategoryProductsParams({
    required this.subCategoryId,
    super.page,
    super.perPage,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'filter[categories.id]': subCategoryId,
      'page': page,
      'per_page': perPage,
    };
  }
}
