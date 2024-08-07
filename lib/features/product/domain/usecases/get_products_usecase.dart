part of '../domain_imports.dart';

class GetProductsUsecase implements UseCaseWithoutParam<List<Product>> {
  final ProductRepository repository;

  const GetProductsUsecase({required this.repository});

  @override
  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getProducts();
  }
}
