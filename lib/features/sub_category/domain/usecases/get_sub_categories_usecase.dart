part of '../domain_imports.dart';

class GetSubCategoriesUsecase implements UseCase<ApiResponse<List<SubCategory>>, int> {
  final SubCategoryRepository repository;

  const GetSubCategoriesUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<List<SubCategory>>>> call(int param) async {
    return await repository.getSubCategories(param);
  }
}
