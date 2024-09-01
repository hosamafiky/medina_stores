part of '../data_imports.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  const ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<Product>>>> getSubCategoryProducts(GetCategoryProductsParams params) async {
    return await remoteDataSource.getSubCategoryProducts(params).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<Product>>>> getBrandProducts(GetBrandProductsParams params) async {
    return await remoteDataSource.getBrandProducts(params).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<ProductDetails>>> getProductDetails(String slug) async {
    return await remoteDataSource.getProductDetails(slug).handleCallbackWithFailure;
  }
}
