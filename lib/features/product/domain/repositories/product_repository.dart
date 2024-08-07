part of '../domain_imports.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, Product>> addProduct(AddProductParams params);
}
