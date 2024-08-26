part of '../data_imports.dart';

class SubCategoryRepositoryImpl implements SubCategoryRepository {
  final SubCategoryRemoteDataSource remoteDataSource;

  const SubCategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ApiResponse<List<SubCategory>>>> getSubCategories(int categoryId) async {
    return await remoteDataSource.getSubCategories(categoryId).handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<SubCategory>>> addSubCategory(AddSubCategoryParams params) async {
    return await remoteDataSource.addSubCategory(params).handleCallbackWithFailure;
  }
}
