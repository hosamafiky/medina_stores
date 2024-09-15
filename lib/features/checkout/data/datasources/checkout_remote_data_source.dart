part of '../data_imports.dart';

abstract class CheckoutRemoteDataSource {
  Future<ApiResponseModel<CheckoutModel>> getCheckoutData();
  Future<ApiResponseModel<List<PaymentGateModel>>> getPaymentGates();
}

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  @override
  Future<ApiResponseModel<CheckoutModel>> getCheckoutData() async {
    final request = ApiRequest(
      method: RequestMethod.get,
      path: ApiConstants.endPoints.CHECKOUT,
      headers: AppNavigator.rootContext!.currentAddress?.asHeader,
    );

    return await DependencyHelper.instance.get<ApiService>().callApi<CheckoutModel>(
          request,
          mapper: (json) => ApiResponseModel.fromMap(
            json,
            mapper: (data) => CheckoutModel.fromMap(data['data']),
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
