part of '../domain_imports.dart';

class AddProductUsecase implements UseCase<ApiResponse<Product>, AddProductParams> {
  final ProductRepository repository;

  const AddProductUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<Product>>> call(AddProductParams params) async {
    return repository.addProduct(params);
  }
}

class AddProductParams {
  Map<String, dynamic> toMap() {
    return {
      "en": {"name": "Flutter App Test", "address": "Mansoura"},
      "ar": {"name": "إختبار تطبيق فلاتر", "address": "المنصورة"},
      "region_id": 1,
      "location": [
        [30.811107371271085, 30.71377132793872],
        [30.811107371271085, 30.71377132793872],
        [30.811107371271085, 30.71377132793872],
        [30.811107371271085, 30.71377132793872],
        [30.811107371271085, 30.71377132793872]
      ]
    };
  }
}
