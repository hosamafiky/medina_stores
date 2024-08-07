part of '../data_imports.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> get getProducts;
  Future<ProductModel> addProduct(AddProductParams params);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<List<ProductModel>> get getProducts async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.PRODUCTS,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi(
          request,
          mapper: (json) => List<ProductModel>.from(json.map((x) => ProductModel.fromMap(x))),
        );
  }

  @override
  Future<ProductModel> addProduct(AddProductParams params) async {
    final request = ApiRequest(
      method: RequestMethod.post,
      path: ApiConstants.endPoints.PRODUCTS,
      body: params.toMap(),
    );

    return await DependencyHelper.instance.get<ApiService>().callApi(
          request,
          mapper: (json) => ProductModel.fromMap(json),
        );
  }
}