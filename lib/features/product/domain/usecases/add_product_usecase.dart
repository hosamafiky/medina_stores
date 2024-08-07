part of '../domain_imports.dart';

class AddProductUsecase implements UseCase<Product, AddProductParams> {
  final ProductRepository repository;

  const AddProductUsecase({required this.repository});

  @override
  Future<Either<Failure, Product>> call(AddProductParams params) async {
    return repository.addProduct(params);
  }
}

class AddProductParams {
  final String title;
  final String body;

  const AddProductParams({
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'userId': 1,
    };
  }
}
