part of '../domain_imports.dart';

class GetYouMayLikeProductsUsecase extends UseCase<ApiResponse<List<Product>>, String> {
  final ProductRepository repository;

  GetYouMayLikeProductsUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<List<Product>>>> call(String param) async {
    return await repository.getYouMayLikeProducts(param);
  }
}
