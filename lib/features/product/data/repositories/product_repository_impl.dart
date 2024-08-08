part of '../data_imports.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  const ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ApiResponse<List<Product>>>> getProducts() async {
    return await remoteDataSource.getProducts.handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<Product>>> addProduct(AddProductParams params) async {
    return await remoteDataSource.addProduct(params).handleCallbackWithFailure;
  }
}
