part of '../data_imports.dart';

abstract class CartRemoteDataSource {
  Future<ApiResponseModel<CartDataModel>> get getCartData;
  Future<ApiResponseModel<void>> addToCart(AddCartParams params);
  Future<ApiResponseModel<void>> removeFromCart(int productId);
  Future<ApiResponseModel<void>> updateQuantity(UpdateCartQuantityParams params);
  Future<ApiResponseModel<CheckoutDataModel>> getCheckoutData();
  Future<ApiResponseModel<List<PaymentGateModel>>> getPaymentGates();
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  @override
  Future<ApiResponseModel<CartDataModel>> get getCartData async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.CART,
      headers: AppNavigator.rootContext!.currentAddress?.asHeader,
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

  @override
  Future<ApiResponseModel<void>> updateQuantity(UpdateCartQuantityParams params) async {
    final request = ApiRequest(
      method: RequestMethod.put,
      path: '${ApiConstants.endPoints.CART}/${params.cart.id}',
      body: params.toMap(),
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<void>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(json),
        );
  }

  @override
  Future<ApiResponseModel<CheckoutDataModel>> getCheckoutData() async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.CHECKOUT,
      headers: AppNavigator.rootContext!.currentAddress?.asHeader,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<CheckoutDataModel>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => CheckoutDataModel.fromMap(data['data']),
          ),
        );
  }

  @override
  Future<ApiResponseModel<List<PaymentGateModel>>> getPaymentGates() async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.PAYMENT_GATES,
      headers: AppNavigator.rootContext!.currentAddress?.asHeader,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<List<PaymentGateModel>>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => List<PaymentGateModel>.from(data['data'].map((e) => PaymentGateModel.fromMap(e))),
          ),
        );
  }
}
