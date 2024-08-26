part of '../domain_imports.dart';

abstract class SubCategoryRepository {
  Future<Either<Failure, ApiResponse<List<SubCategory>>>> getSubCategories(int categoryId);
  Future<Either<Failure, ApiResponse<SubCategory>>> addSubCategory(AddSubCategoryParams params);
}
