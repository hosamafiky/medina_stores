part of '../domain_imports.dart';

class AddBrandUsecase implements UseCase<ApiResponse<Brand>, AddBrandParams> {
  final BrandRepository repository;

  const AddBrandUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<Brand>>> call(AddBrandParams params) async {
    return repository.addBrand(params);
  }
}

class AddBrandParams {
  Map<String, dynamic> toMap() {
    return {};
  }
}
