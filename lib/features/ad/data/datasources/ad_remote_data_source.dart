part of '../data_imports.dart';

abstract class AdRemoteDataSource {
  Future<ApiResponse<PaginatedList<Ad>>> getAds(GetPaginatedListParams params);
}

class AdRemoteDataSourceImpl implements AdRemoteDataSource {
  @override
  Future<ApiResponse<PaginatedList<Ad>>> getAds(GetPaginatedListParams params) async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.ADS,
      queryParameters: params.toMap(),
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<PaginatedList<Ad>>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(
            json,
            mapper: (data) => PaginatedList.fromMap(data['data'], mapper: (x) => AdModel.fromMap(x)),
          ),
        );
  }
}
