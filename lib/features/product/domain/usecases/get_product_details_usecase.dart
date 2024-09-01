part of '../domain_imports.dart';

class GetProductDetailsUsecase extends UseCase<ApiResponse<ProductDetails>, String> {
  final ProductRepository repository;

  GetProductDetailsUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<ProductDetails>>> call(String param) async {
    return await repository.getProductDetails(param);
  }
}
