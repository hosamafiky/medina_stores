part of '../data_imports.dart';

class StaticPageRepositoryImpl implements StaticPageRepository {
  final InternetConnectionChecker connectionChecker;
  final StaticPageRemoteDataSource remoteDataSource;
  final StaticPageLocalDataSource localDataSource;

  const StaticPageRepositoryImpl({
    required this.remoteDataSource,
    required this.connectionChecker,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, ApiResponse<String>>> getStaticPageData(String path) async {
    if (await connectionChecker.hasConnection) {
      try {
        final brands = await remoteDataSource.getStaticPageData(path);
        await localDataSource.cacheStaticPageData(brands.data!, path);
        return Right(brands);
      } on NoInternetConnectionException {
        try {
          final data = await localDataSource.getStaticPageData(path);
          return Right(data);
        } on CacheException catch (e) {
          return Left(CacheFailure(response: e.response));
        }
      } on AppException catch (e) {
        return Left(e.handleFailure);
      }
    } else {
      try {
        final data = await localDataSource.getStaticPageData(path);
        return Right(data);
      } on CacheException catch (e) {
        return Left(CacheFailure(response: e.response));
      }
    }
  }
}
