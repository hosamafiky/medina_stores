part of '../data_imports.dart';

abstract class BrandRemoteDataSource {
  Future<ApiResponse<List<BrandModel>>> get getBrands;
  Future<ApiResponse<BrandModel>> addBrand(AddBrandParams params);
}

class BrandRemoteDataSourceImpl implements BrandRemoteDataSource {
  @override
  Future<ApiResponse<List<BrandModel>>> get getBrands async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.BRANDS,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<List<BrandModel>>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(
            json,
            mapper: (data) => List<BrandModel>.from(data['data'].map((x) => BrandModel.fromMap(x))),
          ),
        );
  }

  @override
  Future<ApiResponse<BrandModel>> addBrand(AddBrandParams params) async {
    final request = ApiRequest(
      method: RequestMethod.post,
      path: "/dashboard/branches",
      body: params.toMap(),
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<BrandModel>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(
            json,
            mapper: (data) => BrandModel.fromMap(data),
          ),
        );
  }
}
