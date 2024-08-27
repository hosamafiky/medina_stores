part of '../domain_imports.dart';

class GetBrandsUsecase implements UseCaseWithoutParam<ApiResponse<List<Brand>>> {
  final BrandRepository repository;

  const GetBrandsUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<List<Brand>>>> call() async {
    return await repository.getBrands();
  }
}

