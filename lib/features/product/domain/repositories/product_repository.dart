part of '../domain_imports.dart';

abstract class ProductRepository {
  Future<Either<Failure, ApiResponse<PaginatedList<Product>>>> getSubCategoryProducts(GetCategoryProductsParams params);
  Future<Either<Failure, ApiResponse<PaginatedList<Product>>>> getBrandProducts(GetBrandProductsParams params);
  Future<Either<Failure, ApiResponse<ProductDetails>>> getProductDetails(String slug);
  Future<Either<Failure, ApiResponse<List<ProductModel>>>> getRelatedProducts(String slug);
  Future<Either<Failure, ApiResponse<List<ProductModel>>>> getYouMayLikeProducts(String slug);
  Future<Either<Failure, ApiResponse<PaginatedList<ProductModel>>>> getFavoriteProducts(GetPaginatedListParams params);
  Future<Either<Failure, ApiResponse<List<Product>>>> getSuggestedCartProducts();
  Future<Either<Failure, ApiResponse<PaginatedList<Product>>>> getLatestProducts(GetPaginatedListParams params);
  Future<Either<Failure, ApiResponse<PaginatedList<Product>>>> getSearchProducts(String query);
  Future<Either<Failure, ApiResponse<bool>>> toggleFavorite(int productId);
}
