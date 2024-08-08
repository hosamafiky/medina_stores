part of '../data_imports.dart';

abstract class ProductRemoteDataSource {
  Future<ApiResponse<List<ProductModel>>> get getProducts;
  Future<ApiResponse<ProductModel>> addProduct(AddProductParams params);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<ApiResponse<List<ProductModel>>> get getProducts async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: "/dashboard/branches",
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<List<ProductModel>>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(
            json,
            mapper: (data) => List<ProductModel>.from(data['data'].map((x) => ProductModel.fromMap(x))),
          ),
        );
  }

  @override
  Future<ApiResponse<ProductModel>> addProduct(AddProductParams params) async {
    final request = ApiRequest(
      method: RequestMethod.post,
      path: "/dashboard/branches",
      body: params.toMap(),
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<ProductModel>(
          request,
          mapper: (json) => ApiResponse.fromMapSuccess(
            json,
            mapper: (data) => ProductModel.fromMap(data),
          ),
        );
  }
}
