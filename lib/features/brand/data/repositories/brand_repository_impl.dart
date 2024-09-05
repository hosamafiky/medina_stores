part of '../data_imports.dart';

class BrandRepositoryImpl implements BrandRepository {
  final InternetConnectionChecker checker;
  final BrandRemoteDataSource remoteDataSource;
  final BrandLocalDataSource localDataSource;

  const BrandRepositoryImpl({
    required this.checker,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, ApiResponse<List<Brand>>>> getBrands() async {
    if (await checker.hasConnection) {
      try {
        final brands = await remoteDataSource.getBrands;
        final brandsToCache = brands.data!.map((brand) => BrandModel.fromBrand(brand)).toList();
        await localDataSource.cacheBrands(brandsToCache);
        return Right(brands);
      } on NoInternetConnectionException {
        try {
          final brands = await localDataSource.getCachedBrands();
          return Right(ApiResponseModel(data: brands));
        } on CacheException catch (e) {
          return Left(CacheFailure(response: e.response));
        }
      } on AppException catch (e) {
        return Left(e.handleFailure);
      }
    } else {
      try {
        final brands = await localDataSource.getCachedBrands();
        return Right(ApiResponseModel(data: brands));
      } on CacheException catch (e) {
        return Left(CacheFailure(response: e.response));
      }
    }
  }
}
