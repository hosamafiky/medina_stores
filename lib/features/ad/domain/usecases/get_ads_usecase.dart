part of '../domain_imports.dart';

class GetAdsUsecase implements UseCase<ApiResponse<PaginatedList<Ad>>, GetPaginatedListParams> {
  final AdRepository repository;

  const GetAdsUsecase({required this.repository});

  @override
  Future<Either<Failure, ApiResponse<PaginatedList<Ad>>>> call(GetPaginatedListParams param) async {
    return await repository.getAds(param);
  }
}
