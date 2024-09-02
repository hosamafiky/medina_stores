part of '../data_imports.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final InternetConnectionChecker checker;
  final CategoryRemoteDataSource remoteDataSource;
  final CategoryLocalDataSource localDataSource;

  const CategoryRepositoryImpl({
    required this.checker,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, ApiResponse<List<Category>>>> getCategories() async {
    if (await checker.hasConnection) {
      try {
        final categories = await remoteDataSource.getCategories;
        final categoriesToCache = categories.data!.map((category) => CategoryModel.fromCategory(category)).toList();
        await localDataSource.cacheCategories(categoriesToCache);
        return Right(categories);
      } on AppException catch (e) {
        return Left(e.handleFailure);
      }
    } else {
      try {
        final categories = await localDataSource.getCachedCategories();
        return Right(ApiResponseModel(data: categories));
      } on CacheException catch (e) {
        return Left(CacheFailure(response: e.response));
      }
    }
  }
}
