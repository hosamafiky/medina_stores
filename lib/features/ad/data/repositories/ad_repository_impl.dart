part of '../data_imports.dart';

class AdRepositoryImpl implements AdRepository {
  final AdRemoteDataSource remoteDataSource;

  const AdRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<Ad>>>> getAds(GetPaginatedListParams params) async {
    return await remoteDataSource.getAds(params).handleCallbackWithFailure;
  }
}
