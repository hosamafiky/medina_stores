part of '../data_imports.dart';

abstract class BrandRemoteDataSource {
  Future<ApiResponseModel<List<BrandModel>>> get getBrands;
}

class BrandRemoteDataSourceImpl implements BrandRemoteDataSource {
  @override
  Future<ApiResponseModel<List<BrandModel>>> get getBrands async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.BRANDS,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<List<BrandModel>>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => List<BrandModel>.from(data['data'].map((x) => BrandModel.fromMap(x))),
          ),
        );
  }
}
