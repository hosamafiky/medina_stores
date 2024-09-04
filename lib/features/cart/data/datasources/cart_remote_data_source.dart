part of '../data_imports.dart';

abstract class CartRemoteDataSource {
  Future<ApiResponseModel<CartDataModel>> get getCartData;
  Future<ApiResponseModel<void>> addToCart(AddCartParams params);
  Future<ApiResponseModel<void>> removeFromCart(int productId);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  @override
  Future<ApiResponseModel<CartDataModel>> get getCartData async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.CART,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<CartDataModel>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => CartDataModel.fromMap(data['data']),
          ),
        );
  }

  @override
  Future<ApiResponseModel<void>> addToCart(AddCartParams params) async {
    final request = ApiRequest(
      method: RequestMethod.post,
      path: ApiConstants.endPoints.CART,
      body: params.toMap(),
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<void>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(json),
        );
  }

  @override
  Future<ApiResponseModel<void>> removeFromCart(int cartId) async {
    final request = ApiRequest(
      method: RequestMethod.delete,
      path: '${ApiConstants.endPoints.CART}/$cartId',
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<void>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(json),
        );
  }
}
