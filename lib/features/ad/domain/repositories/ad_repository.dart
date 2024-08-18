part of '../domain_imports.dart';

abstract class AdRepository {
  Future<Either<Failure, ApiResponse<PaginatedList<Ad>>>> getAds(GetPaginatedListParams params);
}
