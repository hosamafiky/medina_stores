part of '../domain_imports.dart';

abstract class ProductRepository {
  Future<Either<Failure, ApiResponse<List<Product>>>> getProducts();
  Future<Either<Failure, ApiResponse<Product>>> addProduct(AddProductParams params);
}
