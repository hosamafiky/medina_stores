part of '../data_imports.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  const CategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ApiResponse<List<Category>>>> getCategories() async {
    return await remoteDataSource.getCategories.handleCallbackWithFailure;
  }

  @override
  Future<Either<Failure, ApiResponse<Category>>> addCategory(AddCategoryParams params) async {
    return await remoteDataSource.addCategory(params).handleCallbackWithFailure;
  }
}
