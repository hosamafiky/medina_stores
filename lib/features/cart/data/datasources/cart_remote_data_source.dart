part of '../data_imports.dart';

abstract class CartRemoteDataSource {
  Future<ApiResponseModel<List<CartModel>>> get getCarts;
  Future<ApiResponseModel<CartModel>> addToCart(AddCartParams params);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  @override
  Future<ApiResponseModel<List<CartModel>>> get getCarts async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.CART,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<List<CartModel>>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => List<CartModel>.from(data['data'].map((x) => CartModel.fromMap(x))),
          ),
        );
  }

  @override
  Future<ApiResponseModel<CartModel>> addToCart(AddCartParams params) async {
    final request = ApiRequest(
      method: RequestMethod.post,
      path: ApiConstants.endPoints.CART,
      body: params.toMap(),
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<CartModel>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => CartModel.fromMap(data),
          ),
        );
  }
}
