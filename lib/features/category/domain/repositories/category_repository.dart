part of '../domain_imports.dart';

abstract class CategoryRepository {
  Future<Either<Failure, ApiResponse<List<Category>>>> getCategories();
}
