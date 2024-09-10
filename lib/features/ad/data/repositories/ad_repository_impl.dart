part of '../data_imports.dart';

class AdRepositoryImpl implements AdRepository {
  final InternetConnectionChecker connectionChecker;
  final AdRemoteDataSource remoteDataSource;
  final AdLocalDataSource localDataSource;

  const AdRepositoryImpl({
    required this.connectionChecker,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<Ad>>>> getAds(GetPaginatedListParams params) async {
    if (await connectionChecker.hasConnection) {
      try {
        final ads = await remoteDataSource.getAds(params);
        final adsToCache = ads.data!.list.map((ad) => AdModel.fromAd(ad)).toList();
        await localDataSource.cacheAds(adsToCache);
        return Right(ads);
      } on NoInternetConnectionException {
        try {
          final cachedAds = await localDataSource.getCachedAds();
          return Right(ApiResponse(data: PaginatedList(list: cachedAds)));
        } on CacheException catch (e) {
          return Left(CacheFailure(response: e.response));
        }
      } on AppException catch (e) {
        return Left(e.handleFailure);
      }
    } else {
      try {
        final cachedAds = await localDataSource.getCachedAds();
        return Right(ApiResponse(data: PaginatedList(list: cachedAds)));
      } on CacheException catch (e) {
        return Left(CacheFailure(response: e.response));
      }
    }
  }
}
