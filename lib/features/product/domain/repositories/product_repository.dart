part of '../domain_imports.dart';

abstract class ProductRepository {
  Future<Either<Failure, ApiResponse<PaginatedList<Product>>>> getSubCategoryProducts(GetCategoryProductsParams params);
  Future<Either<Failure, ApiResponse<PaginatedList<Product>>>> getBrandProducts(GetBrandProductsParams params);
  Future<Either<Failure, ApiResponse<ProductDetails>>> getProductDetails(String slug);
}
