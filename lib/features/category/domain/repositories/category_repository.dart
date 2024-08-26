part of '../domain_imports.dart';

abstract class CategoryRepository {
  Future<Either<Failure, ApiResponse<List<Category>>>> getCategories();
  Future<Either<Failure, ApiResponse<Category>>> addCategory(AddCategoryParams params);
}
