part of '../domain_imports.dart';

class GetCategoriesUsecase implements UseCaseWithoutParam<ApiResponse<List<Category>>> {
  final CategoryRepository repository;

  const GetCategoriesUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<List<Category>>>> call() async {
    return await repository.getCategories();
  }
}
