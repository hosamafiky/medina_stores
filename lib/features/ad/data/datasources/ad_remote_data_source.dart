part of '../data_imports.dart';

abstract class AdRemoteDataSource {
  Future<ApiResponseModel<PaginatedListModel<Ad>>> getAds(GetPaginatedListParams params);
}

class AdRemoteDataSourceImpl implements AdRemoteDataSource {
  @override
  Future<ApiResponseModel<PaginatedListModel<Ad>>> getAds(GetPaginatedListParams params) async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.ADS,
      queryParameters: params.toMap(),
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<PaginatedListModel<Ad>>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => PaginatedListModel.fromMap(data['data'], mapper: (x) => AdModel.fromMap(x)),
          ),
        );
  }
}
